#!/bin/sh
#
# [K] (C)2020
#
# input adbyby dir which include sh files, eg: /usr/share/adbyby


if [ ! -d ${1} ];then
    exit 0
fi

for f in ${1}/*.sh; do
    sed -i 's#https://adbyby.coding.net/p/xwhyc-rules/d/xwhyc-rules/git/raw/master/md5.json#https://cdn.jsdelivr.net/gh/kongfl888/ad-rules/md5.json#g' $f
    sed -i 's#https://adbyby.coding.net/p/xwhyc-rules/d/xwhyc-rules/git/raw/master/lazy.txt#https://cdn.jsdelivr.net/gh/kongfl888/ad-rules/lazy.txt#g' $f
    sed -i 's#https://adbyby.coding.net/p/xwhyc-rules/d/xwhyc-rules/git/raw/master/video.txt#https://cdn.jsdelivr.net/gh/kongfl888/ad-rules/video.txt#g' $f
done
