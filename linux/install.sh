: "${LEGACY?Legacy option not set}"
DISK=/dev/sda
BIOS_DISK=/dev/sda1
LVM_DISK=/dev/sda2
# Legacy
LINUX_BOOT_DISK=/dev/sda3

function keep_going() {
    read -p "Continue (y/n)?" CONT
    if [ "$CONT" != "y" ]; then
        exit 0
    fi
}

function setup_legacy() {
    echo "Format, Bios 500Mb ef02, Boot 1G 8300, LVM ??? 8300"
    sgdisk -n 1:2048:1026047 -c 1:"BIOS Boot Partition" -t 1:ef02 $DISK
    sgdisk -n 2:4091899:$(sgdisk -E $DISK) -c 2:LVM -t 2:8e00 $DISK
    sgdisk -n e:1026048:4091898 -c 3:"Linux /boot" -t e:8300 $DISK

    echo "Print disk creation."
    sgdisk -p $DISK

    echo "Every thing all right with the partitions?"
    keep_going

    echo "Setup the encrypted LUKS partition and open it."
    cryptsetup luksFormat $LVM_DISK
    cryptsetup luksOpen $LVM_DISK enc-pv

    echo "We create two logical volumes, a 200M swap parition and the rest will be our root filesystem"
    pvcreate /dev/mapper/enc-pv
    vgcreate vg /dev/mapper/enc-pv
    lvcreate -L 1G -n swap vg
    lvcreate -l '100%FREE' -n root vg

    echo "Forrmat the partitions"
    mkfs.ext2 -L boot $LINUX_BOOT_DISK
    mkfs.ext4 -O dir_index -j -L root /dev/vg/root
    mkswap -L swap /dev/vg/swap

    echo "We mount the partitions we just created under /mnt so we can install NixOS on them."
    mount /dev/vg/root /mnt
    mkdir /mnt/boot
    mount $LINUX_BOOT_DISK /mnt/boot
    swapon /dev/vg/swap
}

function setup_efi() {
    echo "Format, 500MB ef00 EFI, ??? 8300 LVM"
    sgdisk -n 1:2048:1021952 -c 1:EFI -t 1:ef00 $DISK
    sgdisk -n 2:1021953:$(sgdisk -E $DISK) -c 2:LVM -t 2:8300 $DISK

    echo "Print disk creation."
    sgdisk -p $DISK

    echo "Every thing all right with the partitions?"
    keep_going

    echo "Setup the encrypted LUKS partition and open it."
    cryptsetup luksFormat $LVM_DISK
    cryptsetup luksOpen $LVM_DISK enc-pv

    echo "We create two logical volumes, a 1GB swap parition and the rest will be our root filesystem."
    pvcreate /dev/mapper/enc-pv
    vgcreate vg /dev/mapper/enc-pv
    lvcreate -L 1G -n swap vg
    lvcreate -l '100%FREE' -n root vg

    echo "Forrmat the partitions."
    mkfs.fat $BIOS_DISK
    mkfs.ext4 -L root /dev/vg/root
    mkswap -L swap /dev/vg/swap

    echo "We mount the partitions we just created under /mnt so we can install NixOS on them."
    mount /dev/vg/root /mnt
    mkdir /mnt/boot
    mount $BIOS_DISK /mnt/boot
    swapon /dev/vg/swap
}

# Connect to wifi
echo "wpa_passphrase $SSID $PASSWORD >/etc/wpa_supplicant.conf"
echo "systemctl start wpa_supplicant"

# clear all partition, fs etc. labels
wipefs -a $DISK

# create a new empty partition table of GPT type
sgdisk -og $DISK

# Setup Disks
if [[ $LEGACY = true ]]; then
    setup_legacy
else
    setup_efi
fi

echo "Print disk UUID."
blkid $LVM_DISK > uuid.txt

echo "Now generate a NixOS configuration and modify it to our liking. The following is the configuration I started with."
nixos-generate-config --root /mnt

# After this you are done
echo "nixos-install"
echo "nixos-reboot"
echo "ok v1"
