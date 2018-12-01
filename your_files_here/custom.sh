#!/bin/bash
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

##################################
## Add here stuff you need to do #
##################################

### Sample as a proof : fingerprint

echo " FBI : It really works !" > /home/pi/fbi.txt
chown pi.pi /home/pi/fbi.txt

###

##################################
## Do not modify after this      #
##################################
exit 0
