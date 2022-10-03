#!/bin/sh
#
# [K] (C)2020
#
# input adbyby dir which include sh files, eg: /usr/share/adbyby


if [ ! -d ${1} ];then
    exit 0
fi

for f in ${1}/*.sh; do
    sed -i -r 's#https://.*/md5.json#https://cdn.jsdelivr.net/gh/kongfl888/ad-rules/md5.json#g' $f
    sed -i -r 's#https://.*/lazy.txt#https://cdn.jsdelivr.net/gh/kongfl888/ad-rules/lazy.txt#g' $f
    sed -i -r 's#https://.*/video.txt#https://cdn.jsdelivr.net/gh/kongfl888/ad-rules/video.txt#g' $f
done
