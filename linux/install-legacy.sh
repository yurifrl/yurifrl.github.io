DISK=/dev/sda

# Connect to wifi
# wpa_passphrase $SSID $PASSWORD >/etc/wpa_supplicant.conf
# systemctl start wpa_supplicant

# clear all partition, fs etc. labels
wipefs -a $DISK

# create a new empty partition table of GPT type
sgdisk -og $DISK

sgdisk -n 1:2048:1026047 -c 1:"BIOS Boot Partition" -t 1:ef02 $DISK
sgdisk -n 2:1026048:2047998 -c 2:"Linux /boot" -t 2:8300 $DISK
sgdisk -n 3:2047998:$(sgdisk -E $DISK) -c 3:LVM -t 3:8e00 $DISK
LVM_DISK=/dev/sda3

# PRINT
sgdisk -p $DISK

# Print UUID
blkid $LVM_DISK > uuid.txt

exit 1

# Setup the encrypted LUKS partition and open it:
cryptsetup luksFormat $LVM_DISK
cryptsetup luksOpen $LVM_DISK enc-pv

# We create two logical volumes, a 200M swap parition and the rest will be our root filesystem
pvcreate /dev/mapper/enc-pv
vgcreate vg /dev/mapper/enc-pv
lvcreate -L 200M -n swap vg
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
echo "ok v1"
