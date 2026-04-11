GRUB="iso/boot/grub/grub.cfg"
BOOT="iso/boot"
DISTRO="tiny_kernel.iso"
BZIMAGE="arch/x86/boot/bzImage"
INITRAMFS="initrd.img"
KERNEL="kernel"

echo -e "Cleanup ISO.."
rm -rf iso
mkdir -p $BOOT/grub

size() {
	printf "\033[32mSize: %s\033[0m\n" $1
}

echo -e "Rebuild Linux Kernel 6.19 (.config).."
make -j8
size "$(ls -lh $BZIMAGE | cut -d' ' -f5)"
cp $BZIMAGE $BOOT/$KERNEL
echo -e ""

echo -e "Rebuild initramfs > $INITRAMFS.."
cd initramfs &&
	find . -print0 |
	cpio --null -ov --format=newc |
		gzip -9 >../$BOOT/$INITRAMFS && cd ..
size "$(ls -lh $BOOT/$INITRAMFS | cut -d' ' -f5)"
echo -e ""

echo -e "Generate $GRUB.."
touch $GRUB
echo "set timeout=0                   " >>$GRUB
echo "set default=0                   " >>$GRUB
echo "menuentry \"Tiny Kernel 6.19\" {" >>$GRUB
echo "    linux  /boot/$KERNEL        " >>$GRUB
echo "    initrd /boot/$INITRAMFS     " >>$GRUB
echo "}                               " >>$GRUB

echo -e "Rebuild ISO (via grub) > $DISTRO.."
grub-mkrescue -o $DISTRO iso/
echo -e "ISO: $DISTRO"
size "$(ls -lh $DISTRO | cut -d' ' -f5)"
echo -e ""

echo -e "Cleanup ?"
read -p "YES/NO = (1/any):" opt
if [ "$opt" = "1" ]; then
	rm -rf $BOOT
	echo "It's clean now."
else
	echo "BYE!"
fi
