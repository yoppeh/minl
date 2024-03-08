# minl

Scripted build of a minimal linux system based on [Linux From Scratch](http://www.linuxfromscratch.org). This iteration of minl is pretty much LFS 12.1. I am using the name "minl" to avoid people thinking this is somehow an official LFS project. I don't want to take credit for that, as I had nothing to do with building it. All that I have done here is to put those instructions into Bash scripts to execute the instructions in the book with only minimal intervention from the user.

These scripts must be run as root. If you want to work out some way to run as a regular user, check out environment.sh.template, 1-01-filesystem.sh and 2-01-filesystem.sh. This should be buildable from any modern host system with a dev-tools package installed. I use Arch Linux, btw. I suggest messing around with this in a VM until you get comfortable with it. I use [virt_manager](https://virt-manager.org/) running Arch on the host, with a second virtual hard disk used as the target for the minl install.

The scripts are designed so that if one fails, you can fix the issue and then just re-run the install-stage#.sh script that failed and it will resume where it left off, retrying the failed package. You can also run a failed script manually to test whether it works after fixing an issue.

## Procedure

- Change to root `su -`
- Make sure the minl repo is in /root
- `cd /root/minl`
- Make sure your system has all the needed software: `./check.sh`
- Choose a device to install to: USB stick, external USB drive, internal hard drive, whatever.
- Run `fdisk /dev/xxxx`. Using virt-manager, with a qemu vm, I attach two virtual disks to it. The first one has a linux distribution installed on it and the second one is empty for minl. These are named vda and vdb. In this case, I use `fdisk /dev/vdb'. Here, I create the partitions: 30GB for the root partition and a swap partition. In this case, I use the /boot partition for the Arch installation on vda, that way I can boot up the vm and choose to run Arch or minl, once it's installed.
- Run `cp environment.sh.template environment.sh`
- Check environment.sh and set the variables appropriately. The swap partition is optional, you can leave it blank with `SWAP_DEV=`. In my case above: `TARGET_DEV_BOOT=/dev/vda`, `TARGET_DEV_ROOT=vdb`, `TARGET_DEV_SWAP=vdb`, `ROOT_PARTITION=1`, `BOOT_PARTITION=1` and `SWAP_PARTITION=2`. Set the KERNEL_CONFIG appropriately. For example, in the case of this vm, I use `KERNEL_CONFIG=kernel-config.kvm`. If you're doing this in a VirtualBox VM, you could set `KERNEL_CONFIG=kernel-config.virtualbox`. You may need to tweak the kernel settings. Set TIMEZONE to your desired timezone. Example: `TIMEZONE=America/Chicago`. You can set COMPILE_FLAGS to any additional flags you want to pass to gcc during compilation. I recommend leaving this blank. FMT_ROOT, FMT_BOOT and FMT_SWAP should be set to "1" if you want the corresponding partition to be formatted. In the example vm case, I would set FMT_ROOT and FMT_SWAP to "1" and leave FMT_BOOT="0", since I am using the existing boot partition. Set ETH_DEV and WIFI_DEV to the names for those devices. Finally, set ROOT_PASSWORD to the initial password to assign to root.
- Run `./get-sources.sh` to download all the source tarballs from the internet. This script will check if all the sources have been downloaded successfully and report which ones did not so that you can manually troubleshoot.
- Run `./install-stage1.sh` to begin the stage 1 installation.
- Run `cd /sources`
- Run `./install-stage2.sh`
- Run `cd /sources`
- Run `./install-stage3.sh`
- Run `cd ~`
- Run `rm -rf /sources`
- Run `rm -rf /progress`

There are two other scripts provided: `rm-install.sh`, which removes a minl installation, based on the contents of `environment.sh` and `rm-sources.sh` which deletes downloaded source packages.