#!/bin/sh
#
# [K] (C)2022
#

echo "get rules proc"

f_md5() {
	m5=`md5sum $1 | cut -d ' ' -f1`
	echo "$m5" | sed "s/ //g"
}

mkdir -p /tmp/myrules
mkdir -p /tmp/myrules/old
mkdir -p /tmp/myrules/tmp

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt -O /tmp/myrules/lazy.txt

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt -O /tmp/myrules/video.txt

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/hacamer/AdRule/main/rules-admin.txt -O /tmp/myrules/tmp/h-admin.txt

[ -s /tmp/myrules/tmp/h-admin.txt ] && cat /tmp/myrules/tmp/h-admin.txt >> /tmp/myrules/lazy.txt

if [ -f /tmp/myrules/old/lazy.txt ]; then
oldh1l=`head -n 1 /tmp/myrules/old/lazy.txt`
sed -i -r -e "/^\!/d" -e "/^\s*$/d" /tmp/myrules/old/lazy.txt
fi

if [ -f /tmp/myrules/old/video.txt ]; then
oldh1v=`head -n 1 /tmp/myrules/old/video.txt`
sed -i -r -e "/^\!/d" -e "/^\s*$/d" /tmp/myrules/old/video.txt
fi

if [ -f /tmp/myrules/old/lazy2.txt ]; then
oldh1l2=`grep '^\! Version:' /tmp/myrules/old/lazy2.txt | head -n 1`
sed -i -r -e "/^\!/d" -e "/\[.*\]/d" -e "/^\s*$/d" /tmp/myrules/old/lazy2.txt
fi

if [ -f /tmp/myrules/old/video2.txt ]; then
oldh1v2=`grep '^\! Version:' /tmp/myrules/old/video2.txt | head -n 1`
sed -i -r -e "/^\!/d" -e "/\[.*\]/d" -e "/^\s*$/d" /tmp/myrules/old/video2.txt
fi

if [ ! -s "/tmp/myrules/lazy.txt" -a -f /tmp/myrules/old/lazy.txt ]; then
    cp -f /tmp/myrules/old/lazy.txt /tmp/myrules/lazy.txt
fi

if [ ! -s "/tmp/myrules/video.txt" -a -f /tmp/myrules/old/video.txt ]; then
    cp -f /tmp/myrules/old/video.txt /tmp/myrules/video.txt
fi

sed -i "/\[*\]/d" /tmp/myrules/lazy.txt
sed -i "/\[*\]/d" /tmp/myrules/video.txt

sed -i -r -e "/^\!/d" -e "/^！/d" -e "/^\s*$/d" /tmp/myrules/lazy.txt
sed -i -r -e "/^\!/d" -e "/^！/d" -e "/^\s*$/d" /tmp/myrules/video.txt

cp -f /tmp/myrules/lazy.txt /tmp/myrules/lazy2.txt
cp -f /tmp/myrules/video.txt /tmp/myrules/video2.txt

sh $GITHUB_WORKSPACE/scripts/edit.sh

sed -i -r "/^\s*$/d" /tmp/myrules/lazy.txt
sed -i -r "/^\s*$/d" /tmp/myrules/video.txt

DATE=`date +%Y-%m-%d\ %H:%M:%S`

oldlmd5="$(f_md5 /tmp/myrules/old/lazy.txt)"
oldvmd5="$(f_md5 /tmp/myrules/old/video.txt)"

newlmd5="$(f_md5 /tmp/myrules/lazy.txt)"
newvmd5="$(f_md5 /tmp/myrules/video.txt)"

sed -i "1i\! Modified from xinggsf,hacamer.Thanks" /tmp/myrules/lazy.txt
sed -i "1i\! Modified from xinggsf.Thanks" /tmp/myrules/video.txt

if [ "$oldlmd5" = "$newlmd5" ];then
sed -i "1i${oldh1l}" /tmp/myrules/lazy.txt
else
sed -i "1i\! ----Updatetime: $DATE by:Mr.K----" /tmp/myrules/lazy.txt
fi

if [ "$oldvmd5" = "$newvmd5" ];then
sed -i "1i${oldh1v}" /tmp/myrules/video.txt
else
sed -i "1i\! ----Updatetime: $DATE by:Mr.K----" /tmp/myrules/video.txt
fi

oldlmd52="$(f_md5 /tmp/myrules/old/lazy2.txt)"
oldvmd52="$(f_md5 /tmp/myrules/old/video2.txt)"

newlmd52="$(f_md5 /tmp/myrules/lazy2.txt)"
newvmd52="$(f_md5 /tmp/myrules/video2.txt)"

if [ "$oldlmd52" != "$newlmd52" ];then
oldh1l2="! Version: $DATE"
fi

if [ "$oldvmd52" != "$newvmd52" ];then
oldh1v2="! Version: $DATE"
fi

sed -i "1i\! Modified from xinggsf,hacamer.Thanks" /tmp/myrules/lazy2.txt
sed -i "1i\! Modified from xinggsf.Thanks" /tmp/myrules/video2.txt
sed -i "1i\! Expires: 12 Hours" /tmp/myrules/lazy2.txt
sed -i "1i\! Expires: 12 Hours" /tmp/myrules/video2.txt
sed -i "1i$oldh1l2" /tmp/myrules/lazy2.txt
sed -i "1i$oldh1v2" /tmp/myrules/video2.txt
sed -i "1i\! Title: Lazy Created by MrK" /tmp/myrules/lazy2.txt
sed -i "1i\! Title: Video Created by MrK" /tmp/myrules/video2.txt
sed -i "1i\[Adblock Plus 2.0]" /tmp/myrules/lazy2.txt
sed -i "1i\[Adblock Plus 2.0]" /tmp/myrules/video2.txt

rm -rf /tmp/myrules/tmp
