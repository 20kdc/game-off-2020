#!/bin/sh
rm -rf /media/ramdisk/repo
git clone --bare . /media/ramdisk/repo
tar -cf /home/20kdc/Documents/Sync/moonshot/moonshot.tar /media/ramdisk/repo
#cd /home/20kdc/Documents/Sync/
#./soulgem.x86_64
