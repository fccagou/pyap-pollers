#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}
notifier='local'

MDADM='/usr/sbin/mdadm'


raid="${1}"
raid_desc=${raid//\//_}

if [ -z "${raid}" ] 
then
    touch ${DB}/${notifier}_raid${raid_desc}_unknown
    exit -1
fi

if [ ! -e "${raid}" ]
then
    touch ${DB}/${notifier}_raid${raid_desc}_unknown
    exit -1
fi

${MDADM} --detail ${raid}  | egrep '(Active|Working|Failed) Devices :' \
   | cut -d: -f2 | xargs \
   | while read a w f
do
   if [ $f -gt 0 ]
   then
       touch ${DB}/${notifier}_raid${raid_desc}_crit
       exit 1
   fi

   if [ $w -lt $a ]
   then
       touch ${DB}/${notifier}_raid${raid_desc}_warn
       exit 1
   fi

   rm -f  ${DB}/${notifier}_raid${raid_desc}_*
    
done


