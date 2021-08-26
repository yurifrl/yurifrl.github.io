# Check for internet
ping google.com

# List partitions
fdisk -l

# Change partition types
cfdisk

#
timedatectl set-ntp true

#
mount /dev/sda<root> /mnt

#
mkdir /dev/sda<home>
mount /dev/sda<home> /mnt/home

#
pacstrap /mnt base base-devel
