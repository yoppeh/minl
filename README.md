# minl
Scripted build of a minimal linux system based on [Linux From Scratch](http://www.linuxfromscratch.org).

These scripts must be run as root. If you want to work out some way to run as a regular user, check out environment.sh, 1-01-filesystem.sh and 2-01-filesystem.sh.

## Procedure
- `su -`
- Make sure the minl repo is in /root
- `cd /root/minl`
- Choose a device to install to: USB stick, external USB drive, internal hard drive, whatever.
- Run `fdisk /dev/xxxx`. My USB stick gets recognized as /dev/sda, so I run `fdisk /dev/sda` and create a 110GB root partition, type 82, make it active with the `a` command, then create a 2GB swap partition with type 80. `w` to write the changes and exit fdisk.
- Check environment.sh and set the variables appropriately. The swap partition is optional, you can leave it blank with `SWAP_DEV=`. In my case above: `TARGET_DEV=/dev/sda`, `ROOT_DEV=/dev/sda1`, `ROOT_PARTITION=1`, `SWAP_DEV=/dev/sda2`
- Run `./get-sources.sh`
- Run `./install-stage1.sh`
- Run `cd /sources`
- Run `./install-stage2.sh`
- Run `exit`
- Run `chroot "/mnt/minl" HOME=/root TERM="$TERM" PS1='\u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login`
- Run `./install-stage3.sh`

