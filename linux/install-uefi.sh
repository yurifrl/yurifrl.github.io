DISK=/dev/sda

# Connect to wifi
wpa_passphrase $SSID $PASSWORD >/etc/wpa_supplicant.conf
systemctl start wpa_supplicant

# clear all partition, fs etc. labels
wipefs -a $DISK

# create a new empty partition table of GPT type
sgdisk -og $DISK

# 500M type ef00 EFI
sgdisk -n 1:2048:1021952 -c 1:EFI -t 1:ef00 $DISK

# <THE_REST> type 8300 LVM
sgdisk -n 2:1021953:$(sgdisk -E $DISK) -c 2:LVM -t 2:8300 $DISK

# PRINT
sgdisk -p $DISK

# Print UUID
blkid /dev/sda2 > uuid.txt

# Setup the encrypted LUKS partition and open it:
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 enc-pv

# We create two logical volumes, a 8GB swap parition and the rest will be our root filesystem
pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg

# Forrmat the partitions:
mkfs.fat /dev/sda1
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap

# We mount the partitions we just created under /mnt so we can install NixOS on them.
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/vg/swap

# Now generate a NixOS configuration and modify it to our liking. The following is the configuration I started with.
nixos-generate-config --root /mnt

# After this you are done
echo "nixos-install"
echo "nixos-reboot"
