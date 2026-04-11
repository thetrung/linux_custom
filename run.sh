echo "Run Option:"
echo "1. pure kernel"
echo "2. full iso"
read -p "option (1/2):" opt
if [ "$opt" = "1" ]; then
	qemu-system-x86_64 \
		-kernel arch/x86/boot/bzImage \
		-initrd iso/boot/initrd.img \
		-vga std -display sdl
else
	qemu-system-x86_64 -cdrom tiny_kernel.iso
fi
