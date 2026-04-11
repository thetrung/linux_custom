IMAGE="limine.iso"
rm $IMAGE
# rm -rf iso
# mkdir -p iso/EFI/BOOT
# cp arch/x86/boot/bzImage iso/

cd iso &&
	xorriso -as mkisofs -R -r -J -b limine-bios-cd.bin \
		-no-emul-boot -boot-load-size 4 \
		-boot-info-table -hfsplus \
		-apm-block-size 2048 --efi-boot limine-uefi-cd.bin \
		-efi-boot-part --efi-boot-image --protective-msdos-label \
		. -o ../$IMAGE
cd ..

limine bios-install $IMAGE

qemu-system-x86_64 -cdrom $IMAGE
