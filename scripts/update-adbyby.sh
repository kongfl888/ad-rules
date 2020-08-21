#!/bin/sh
#
# [K] (C)2020
#
# input adbyby dir which include sh files, eg: /usr/share/adbyby

for f in ${1}/*.sh; do
    sed -i 's#https://adbyby.coding.net/p/xwhyc-rules/d/xwhyc-rules/git/raw/master/md5.json#https://raw.githubusercontent.com/kongfl888/ad-rules/master/md5.json#g' $f
    sed -i 's#https://adbyby.coding.net/p/xwhyc-rules/d/xwhyc-rules/git/raw/master/lazy.txt#https://raw.githubusercontent.com/kongfl888/ad-rules/master/lazy.txt#g' $f
    sed -i 's#https://adbyby.coding.net/p/xwhyc-rules/d/xwhyc-rules/git/raw/master/video.txt#https://raw.githubusercontent.com/kongfl888/ad-rules/master/video.txt#g' $f
done
