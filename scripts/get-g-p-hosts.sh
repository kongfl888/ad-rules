#!/bin/sh
#
# [K] (C)2022
#

f_md5() {
    md5sum $1 | cut -d ' ' -f1
}

htxt="/tmp/myrules/antihosts-gambling-porn.txt"
oldhtxt="/tmp/myrules/old/antihosts-gambling-porn.txt"
oldhtxt1="/tmp/myrules/old/antihosts-gambling-porn1.txt"

mkdir -p /tmp/myrules
mkdir -p /tmp/myrules/old

touch $htxt
touch $oldhtxt
cp -f $oldhtxt $oldhtxt1
sed -i '1,4d' $oldhtxt1

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /tmp/myrules/old/hosts1.txt

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts -O /tmp/myrules/old/hosts2.txt

if [ -s "/tmp/myrules/old/hosts1.txt" -a -s "/tmp/myrules/old/hosts2.txt" ]; then
	awk '{print $0}' /tmp/myrules/old/hosts1.txt /tmp/myrules/old/hosts2.txt |sort|uniq -u > $htxt
else
	cp -f $oldhtxt1 $htxt
fi
sed -i -r -e '/^\s*$/d' -e 's/#.*//' $htxt
sed -i -r '/^[\s ]*$/d' $htxt

if [ "$(f_md5 $oldhtxt1)" = "$(f_md5 $htxt)" ];then
cp -f $oldhtxt $htxt
else
DATE=`date +%Y-%m-%d\ %H:%M:%S`
sed -i "1i\ " $htxt
sed -i "1i\# This hosts lite from StevenBlack/hosts." $htxt
sed -i "1i\# DATE: $DATE" $htxt
sed -i "1i\# Title: Anti gambling and porn by:Mr.K" $htxt
fi
