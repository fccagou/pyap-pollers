#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}


DISKS="${1:-/}"
notifier='local'


for d in ${DISKS}
do
   usage=$(LANG=C df -H $d | grep -v ^Filesy| awk '{ print $5 }')
   usage=${usage//%*}
  
   d=${d//\//_}

   #echo "$d => ${usage}" 
    
   rm -f ${DB}/${notifier}_disk${d}*
   if [ "${usage}" -lt "80" ]; then
      :
   elif [ "${usage}" -lt "90" ]; then
      touch ${DB}/${notifier}_disk${d}_warn
   elif [ "${usage}" -ge "90" ]; then
      touch ${DB}/${notifier}_disk${d}_crit
   else
      touch ${DB}/${notifier}_disk${d}_unknown
   fi

done

