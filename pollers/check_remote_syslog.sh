#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}
NOTIFIER='remote'
LEVEL='crit'

# minutes
DURATION=$(( 10 * 3600 ))

# Syslog datas in $SYSLOGDIR/<ip>/
SYSLOG_FILE_DIR="${1:-/var/log}"

cd ${SYSLOG_FILE_DIR}

NOW=$(date +%s)

for h in $(ls -1d *)
do
   [ ! -d $h ] && continue

   lastfile=$(ls -1tr $h | tail -1)
   lastaccess=$(stat -c'%Z' $h/$lastfile)

   if [ $(( $lastaccess + $DURATION )) -lt $NOW ]
   then
       touch ${DB}/${NOTIFIER}_syslog_${h}_${LEVEL}
   else
       rm -f ${DB}/${NOTIFIER}_syslog_${h}_${LEVEL}
   fi

done


