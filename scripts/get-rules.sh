#!/bin/sh
#
# [K] (C)2020
#

f_md5() {
    md5sum $1 | cut -d ' ' -f1
}

mkdir -p /tmp/myrules
mkdir -p /tmp/myrules/old

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/rule.txt -O /tmp/myrules/lazy.txt

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/mv.txt -O /tmp/myrules/video.txt

if [ -f /tmp/myrules/old/lazy.txt ]; then
oldh1l=`head -n 1 /tmp/myrules/old/lazy.txt`
sed -i "/--Updatetime/d" /tmp/myrules/old/lazy.txt
fi

if [ -f /tmp/myrules/old/video.txt ]; then
oldh1v=`head -n 1 /tmp/myrules/old/video.txt`
sed -i "/--Updatetime/d" /tmp/myrules/old/video.txt
fi

if [ ! -s "/tmp/myrules/lazy.txt" -a -f /tmp/myrules/old/lazy.txt ]; then
    cp -f /tmp/myrules/old/lazy.txt /tmp/myrules/lazy.txt
fi

if [ ! -s "/tmp/myrules/video.txt" -a -f /tmp/myrules/old/video.txt ]; then
    cp -f /tmp/myrules/old/video.txt /tmp/myrules/video.txt
fi

sed -i "/\[*\]/d" /tmp/myrules/lazy.txt
sed -i "/\[*\]/d" /tmp/myrules/video.txt

sh $GITHUB_WORKSPACE/scripts/edit.sh

oldlmd5=$(f_md5 /tmp/myrules/old/lazy.txt)
oldvmd5=$(f_md5 /tmp/myrules/old/video.txt)

newlmd5=$(f_md5 /tmp/myrules/lazy.txt)
newvmd5=$(f_md5 /tmp/myrules/video.txt)

DATE=`date +%Y-%m-%d\ %H:%M:%S`

if [ "$oldlmd5" == "$newlmd5" ];then
sed -i "1i${oldh1l}" /tmp/myrules/lazy.txt
else
sed -i "1i\! ----Updatetime: $DATE by:Mr.K----" /tmp/myrules/lazy.txt
fi

if [ "$oldvmd5" == "$newvmd5" ];then
sed -i "1i${oldh1v}" /tmp/myrules/video.txt
else
sed -i "1i\! ----Updatetime: $DATE by:Mr.K----" /tmp/myrules/video.txt
fi

cp -f /tmp/myrules/lazy.txt /tmp/myrules/lazy2.txt
cp -f /tmp/myrules/video.txt /tmp/myrules/video2.txt

sed -i "1i\[Adblock Plus 2.0]" /tmp/myrules/lazy2.txt
sed -i "1i\[Adblock Plus 2.0]" /tmp/myrules/video2.txt
