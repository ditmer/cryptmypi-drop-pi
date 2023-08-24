#!/bin/bash

###################################
# Ubuntu encrypted stage2-postinstall.sh


# At the time of testing the Ubuntu for rpi works on labels, so we attempt to match.
if echo ${_BLKDEV} | grep -qs "mmcblk"
    then
        __PARTITIONPREFIX=p
    else
        __PARTITIONPREFIX=""
fi
echo 'Setting up partition labels for Ubuntu on ${_BLKDEV}${__PARTITIONPREFIX}.'
dosfslabel ${_BLKDEV}${__PARTITIONPREFIX}1 system-boot
cryptsetup config ${_BLKDEV}${__PARTITIONPREFIX}2 --label writable