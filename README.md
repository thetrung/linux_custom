# custom tiny linux kernel
Size ~861kb with (printk/tty/ELF/initramfs) + GRUB bootloader.

### Fetch Linux repo

    git clone --depth=1 --branch=v6.19 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

### Install 

- Clone this repo same level with above `linux` folder.
- copy any single ELF executable binary you want as `initramfs/init`.
- build: `./build_iso.sh`
- run: `./run.sh` for `kernel/iso` option.

### Note
- didn't work (yet) with fb/drm.
- ISO image size eventually become ~32MB even when `kernel + init` only ~862KB.
- Using isolinux may shrink this down more but not sure to run on actual UEFI machines.
