**fbi-usb**
: First Boot Initialization with a fresh Raspbian on an USB flash drive.

This repository contains code for tuning Raspbian directly after imaging without any access to raspberry or typing any command.

**Requirement**

- A Raspberry pi able to boot on USB (link : https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/msd.md)
- USB Flash Drive able to boot on a Raspberry PI (SanDisk Cruzer Blade for example)

**How to do that ?**

If you want to use this tool, this is because you already have a script that can install/modify a fresh Raspbian.
In this case, you just have to put your own script in your_files_here and modify custom.sh to launch it.

- Flash a raspbian Image on your USB Drive with your favorite tool.
- Download fbi release from this repository on your computer
- Unzip the release
- Add you own scripts in your_files_here directory
- Modify custom.sh to call you own scripts  
- Just copy files (cmdline.txt, README.md) and directories (fbi, your_files_here) over boot partition 
- Confirm that you want to replace cmdline.txt during copy
- Eject USB flash drive from your computer
- Plug USB flash drive on your PI and power on

**Notes :**

By default, custom.sh just write a fbi.txt on /home/pi as a fingerprint.

It is important to note that just after the first boot, as a fresh install, raspbian will expand FS to full size ! 
So if your custom script launch a reboot ... take care about that !
You could introduce a sleep period in custom.sh or edit fbi/files/cmdline.new.txt to remove init=/usr/lib/raspi-config/init_resize.sh before copying files over fresh raspbian ;)
 
**How does it work ?**

fbi overwrite cmdline.txt with a new one which boot on /boot partition and call a busybox script.
This script mount ext4 partition in rw mode and copy fbi files on it, modify /etc/rc.local to call a shell script on first normal boot, restore a classical cmdline.txt and reboot.
After reboot, this shell script cleanup everything and call custom.sh

Enjoy it !  

**About Busybox**

You could learn more about it on https://busybox.net/
This release include a busybox binary with in-built static library.
If you wish,  you could replace it with another static version before copying files over boot partition.
You could obtain a busybox binary by downloading it from https://busybox.net/downloads/binaries/ (choose the right arm version one) or get it from a rapsbian repository (sudo apt-get install busybox-static and look for it in /bin directory)

