#!/bin/sh
#
# [K] (C)2020
#

f_md5() {
    md5sum $1 | cut -d ' ' -f1
}

mkdir -p /tmp/myrules
mkdir -p /tmp/myrules/old

wget -q -T10 -t2 --no-check-certificate https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt -O /tmp/myrules/lazy.txt

wget -q -T10 -t2 --no-check-certificate https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt -O /tmp/myrules/video.txt

if [ ! -s "/tmp/myrules/lazy.txt" -a -f /tmp/myrules/old/lazy.txt ]; then
    cp -f /tmp/myrules/old/lazy.txt /tmp/myrules/lazy.txt
fi

if [ ! -s "/tmp/myrules/video.txt" -a -f /tmp/myrules/old/video.txt ]; then
    cp -f /tmp/myrules/old/video.txt /tmp/myrules/video.txt
fi

sed -i "/\[*\]/d" /tmp/myrules/lazy.txt
sed -i "/\[*\]/d" /tmp/myrules/video.txt

DATE=`date +%Y-%m-%d\ %H:%M:%S`

sed -i "1i\! ----Updatetime: $DATE by:Mr.K----" /tmp/myrules/lazy.txt
sed -i "1i\! ----Updatetime: $DATE by:Mr.K----" /tmp/myrules/video.txt


[ -f "/tmp/myrules/lazy.txt" ] && lazymd5=$(f_md5 /tmp/myrules/lazy.txt)
[ -f "/tmp/myrules/video.txt" ] && videomd5=$(f_md5 /tmp/myrules/video.txt)

echo "{\"lazy\":\"$lazymd5\",\"video\":\"$videomd5\",\"ssllist\":\"\"}" > /tmp/myrules/md5.json
