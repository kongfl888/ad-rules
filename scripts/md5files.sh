#!/bin/sh
#
# [K] (C)2020
#

f_md5() {
    md5sum $1 | cut -d ' ' -f1
}

[ -f "/tmp/myrules/lazy.txt" ] && lazymd5=$(f_md5 /tmp/myrules/lazy.txt)
[ -f "/tmp/myrules/video.txt" ] && videomd5=$(f_md5 /tmp/myrules/video.txt)

echo "{\"lazy\":\"$lazymd5\",\"video\":\"$videomd5\",\"ssllist\":\"\"}" > /tmp/myrules/md5.json

