#!/fbi/bin/busybox sh
#
#
# FBI : First Boot Initializer (C) 2018 Koda59
#
# This Program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This Program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# 2018-12-01 Koda59	v1.0
#

###
### Setting Alias Busybox Commands
###

touch="/fbi/bin/busybox touch"
mount="/fbi/bin/busybox mount"
echo="/fbi/bin/busybox echo"
mkdir="/fbi/bin/busybox mkdir"
mknod="/fbi/bin/busybox mknod"
chmod="/fbi/bin/busybox chmod"
chown="/fbi/bin/busybox chown"
sync="/fbi/bin/busybox sync"
umount="/fbi/bin/busybox umount"
rmdir="/fbi/bin/busybox rmdir"
rm="/fbi/bin/busybox rm"
cp="/fbi/bin/busybox cp"
sleep="/fbi/bin/busybox sleep"
reboot="/fbi/bin/busybox reboot"
mv="/fbi/bin/busybox mv"

$echo "*******"
$echo "Modifying Raspbian"
$echo "*******"
$echo

cd /

# Remount root FS writable
# Create mounting points to work
# Create device node to ext4 partition
# Mount ext4 partition 

$mount -o remount,rw /dev/sda1 /
$mkdir /tmp
$mkdir /new_root
$mount -t tmpfs none /tmp
$mknod /tmp/sda2 b 8 2
$mount -t ext4 /tmp/sda2 /new_root

#####################################################################################################

#######################################
#     REAL WORK to custom Raspbian    #
#######################################

# Allowing ssh access

$touch ssh

#
# Copy fbi script to execute at normal boot and set it to rc.local
#

$cp /fbi/bin/fbi_boot.sh /new_root/home/pi/fbi.sh
$chmod u+rwx,g+rx-w,o+rx-w /new_root/home/pi/fbi.sh
$cp -f /fbi/files/rc.local /new_root/etc/rc.local
$chmod u+rwx,g+rx-w,o+rx-w /new_root/etc/rc.local
$chown 0.0 /new_root/etc/rc.local

#
# Copy original rc.local to /home/pi to restore it first normal reboot
#

$cp /fbi/files/rc.local.origine /new_root/home/pi/rc.local
$chmod u+rwx,g+rx-w,o+rx-w /new_root/home/pi/rc.local
$chown 0.0 /new_root/home/pi/rc.local

#
# Copy & configure perms for custom.sh & all users files
#

$cp -R your_files_here /new_root/home/pi
$mv /new_root/home/pi/your_files_here /new_root/home/pi/fbi
$chmod -R u+rwx,g+rx-w,o+rx-w /new_root/home/pi/fbi
$chown -R 1000.1000 /new_root/home/pi/fbi

#######################################
# End of REAL WORK to custom Raspbian #
#######################################

#####################################################################################################

#
# Umount all stuff and clean up
# 

$sync
$umount /new_root
$rmdir /new_root
$rm /tmp/sda2
$umount /tmp
$rmdir /tmp

#
# Restore normal boot
#
$cp /fbi/files/cmdline.new.txt /cmdline.txt

#
# Sync FS & mount / read-only and reboot
#

$sync
$mount -o remount,ro /dev/sda1 /
$sync

$echo
$echo "*******"
$echo " Work done, wait 3 sec before rebooting !"
$echo "*******"
$sleep 3
$reboot -f
