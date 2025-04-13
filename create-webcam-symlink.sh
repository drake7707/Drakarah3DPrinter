#!/bin/bash

videos=$(find /dev/video*)
for v in $videos
do
   if (udevadm info --query=all --name=$v | grep -q ":capture"); then
     ln -sf $v /dev/webcam
     break
   fi
done
