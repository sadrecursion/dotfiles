#!/bin/bash

set -euo pipefail

echo "arch install script..."

pacstrap -K /mnt base linux linux-firmware sudo
genfstab -U /mnt > /mnt/etc/fstab
install -Dm755 arch-setup.sh /mnt/root/arch-setup.sh
install -Dm644 packages.txt /mnt/root/packages.txt
arch-chroot /mnt /root/arch-setup.sh

echo "arch install completed"
