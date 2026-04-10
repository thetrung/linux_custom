ls -lh arch/x86/boot/bzImage
qemu-system-x86_64 \
	-kernel arch/x86/boot/bzImage \
	-initrd initrd.cpio.gz \
	-vga std -display sdl \
	-append "rdinit=/init"
