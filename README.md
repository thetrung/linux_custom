# custom tiny linux kernel
Could be ~600kb (printk/tty) upto 1.2MB (with fb/drm).


### Fetch Linux repo

    git clone --depth=1 --branch=v6.19 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

### Install 

- Clone this repo right into /linux after fetched.
- Clone busybox also if you want to manually build it, else just get static build anywhere.
- Copy busybox > `initramfs/bin/busybox`
- build initrd > `sh create_initrd.sh`
; build bzImage > `make -j8`
- run with `qemu-full` via `sh run.sh`

### Note
didn't work yet with fb/drm.
