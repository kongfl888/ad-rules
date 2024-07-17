#!/bin/sh
#
# [K] (C)2022
#

f_md5() {
    md5sum $1 | cut -d ' ' -f1
}

htxt="/tmp/myrules/malhosts.txt"
oldhtxt="/tmp/myrules/old/malhosts.txt"

mkdir -p /tmp/myrules
mkdir -p /tmp/myrules/old

touch $htxt
touch $oldhtxt
#cp -f $oldhtxt $oldhtxt1
#sed -i '1,4d' $oldhtxt1

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/MalwareDomainList.com/master/output/domains.list/hosts/ACTIVE/hosts -O /tmp/malhosts.txt


if [ ! -s /tmp/malhosts.txt -a -s $oldhtxt ]; then
    cp -f $oldhtxt $htxt
else
    grep -E "\.(com|net|cn|cc|org)" /tmp/malhosts.txt 2>/dev/null | sort -u >  $htxt
fi
sed -i '/0i0i0i0/d' $htxt
sed -i -r -e 's/#.*//' -e '/^\s*$/d' $htxt
cp -f $oldhtxt /tmp/malhosts_old.txt
sed -i -r -e 's/#.*//' -e '/^\s*$/d' /tmp/malhosts_old.txt

if [ "$(f_md5 /tmp/malhosts_old.txt)" = "$(f_md5 $htxt)" ];then
cp -f $oldhtxt $htxt
else
DATE=`date +%Y-%m-%d\ %H:%M:%S`
sed -i "1i\ " $htxt
sed -i "1i\# This hosts lite from Ultimate-Hosts-Blacklist/MalwareDomainList.com." $htxt
sed -i "1i\# DATE: $DATE" $htxt
sed -i "1i\# Title: Anti gambling and porn by:Mr.K" $htxt
fi
