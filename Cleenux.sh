#!/bin/bash
echo -e

YELLOW="\033[1;33m"
GREEN="\033[32m"
BLINK="\e[5m"
REDL="\e[101m"
RED="\033[0;31m"
END="\033[0m"

echo -e $GREEN"************************************************************************"$ENDCOLOR
echo -e $GREEN"************************** CLEENUX FOR DEBIAN **************************"$ENDCOLOR
echo -e $GREEN"************************      GITHUB/KID-X      ************************"$ENDCOLOR
echo -e $GREEN"************************************************************************"$ENDCOLOR
echo -e
echo -e
                                                                                                                                                                                                                                         
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|debian-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

echo -e $YELLOW"CLEENUX >> CLEARING RETRIEVED PACKAGE FILES..."$RED
sudo apt-get clean
echo -e $GREEN"DONE!"$RED
echo -e

echo -e $YELLOW"CLEENUX >> CLEARING OLD CONFIG FILES..."$RED
sudo apt-get purge $OLDCONF
echo -e $GREEN"DONE!"$RED
echo -e

echo -e $YELLOW"CLEENUX >> CLEARING TRASHED ITEMS..."$RED
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null
echo -e $GREEN"DONE!"$RED
echo -e

echo -e $YELLOW"CLEENUX >> CLEARING OLD KERNELS..."
echo -e $REDL
echo -e $BLINK"WARNING! REMOVING OLD KERNALS COULD CAUSE PROBLEMS. CONTINUE? [Y/N] : "$RED
echo -e 
sudo apt-get purge $OLDKERNELS
echo -e $GREEN"DONE!"$RED
echo -e
echo -e $GREEN

echo -e $BLINK"CLEENUX >> DONE!"$END
echo -e 
