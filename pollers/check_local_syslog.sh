#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}
NOTIFIER='local'
LEVEL='crit'

# minutes
DURATION=$(( 10 * 3600 ))

# Syslog datas in $SYSLOGDIR/
SYSLOG_FILE_DIR="${1:-/var/log}"

cd ${SYSLOG_FILE_DIR}

NOW=$(date +%s)

lastfile=$(ls -1tr | tail -1)
lastaccess=$(stat -c'%Z' $lastfile)

if [ $(( $lastaccess + $DURATION )) -lt $NOW ]
then
    touch ${DB}/${NOTIFIER}_syslog_${LEVEL}
else
    rm -f ${DB}/${NOTIFIER}_syslog_${LEVEL}
fi

