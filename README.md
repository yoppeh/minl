# minl

Scripted build of a minimal linux system based on [Linux From Scratch](http://www.linuxfromscratch.org). This iteration of minl is pretty much LFS 11.2. I am using the name "minl" to avoid people thinking this is somehow an official LFS project.

These scripts must be run as root. If you want to work out some way to run as a regular user, check out environment.sh, 1-01-filesystem.sh and 2-01-filesystem.sh. This should be buildable from any modern host system with a dev-tools package installed. I use Arch Linux.

I don't want to take credit for this distribution procedure: that is pretty much Linux From Scratch and I had nothing to do with building it. All that I have done here is to put those instructions into Bash scripts to execute the instructions in the book with only minimal intervention from the user.

## Procedure

- `su -`
- Make sure the minl repo is in /root
- `cd /root/minl`
- Choose a device to install to: USB stick, external USB drive, internal hard drive, whatever.
- Run `fdisk /dev/xxxx`. My USB stick gets recognized as /dev/sda, so I run `fdisk /dev/sda` and create a 512MB boot partition type EF00, 110GB root partition, type 8200, then create a 2GB swap partition with type 8000. `w` to write the changes and exit fdisk.
- Run `cp environment.sh.template environment.sh`
- Check environment.sh and set the variables appropriately. The swap partition is optional, you can leave it blank with `SWAP_DEV=`. In my case above: `TARGET_DEV=/dev/sda`, `BOOT_PARTITION=1`, `ROOT_PARTITION=2`, `SWAP_PARTITION=3`. Set the KERNEL_CONFIG appropriately. For example, if you're doing this in a VirtualBox VM, you could set `KERNEL_CONFIG=kernel-config.virtualbox`. Set TIMEZONE to your desired timezone. Example: `TIMEZONE=America/Chicago`
- Run `./get-sources.sh`
- Run `./install-stage1.sh`
- Run `cd /sources`
- Run `./install-stage2.sh`
- Run `exit`
- Run `chroot "/mnt/minl" HOME=/root TERM="$TERM" PS1='\u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login`
- Run `./install-stage3.sh`
