#!/bin/sh

remove_line(){
    [ -e "${1}" ] || exit 0
    [ -e "${2}" ] || exit 0

    cat ${2} | while read line;do
        str=${line}
        echo "$str"
        [ ! -z "$str" ] && sed -i "/$str/d" ${1}
    done
}

remove_line /tmp/myrules/video.txt /tmp/patches/remove1.txt
