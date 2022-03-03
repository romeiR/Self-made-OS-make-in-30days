#!/bin/bash
mkdir -p mnt
qemu-img create -f raw disk.img 200M
mkfs.fat -n "MIKAN OS" -s 2 -f 2 -R 32 -F 32 disk.img
mount -o loop disk.img mnt
mkdir -p mnt/EFI/BOOT
cp /root/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi mnt/EFI/BOOT/BOOTX64.EFI
umount mnt
qemu-system-x86_64 -drive if=pflash,file=$HOME/osbook/devenv/OVMF_CODE.fd -drive if=pflash,file=$HOME/osbook/devenv/OVMF_VARS.fd -monitor stdio -hda disk.img