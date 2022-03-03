#!/bin/bash
mount -o loop disk.img mnt
mkdir -p mnt/EFI/BOOT
cp /root/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi mnt/EFI/BOOT/BOOTX64.EFI
cp /root/mikanos/kernel/kernel.elf  /root/mnt
umount mnt
qemu-system-x86_64 -drive if=pflash,file=$HOME/osbook/devenv/OVMF_CODE.fd -drive if=pflash,file=$HOME/osbook/devenv/OVMF_VARS.fd -monitor stdio -hda disk.img