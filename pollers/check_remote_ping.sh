#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}
NOTIFIER=${3:-remote}
LEVEL=${2:-crit}
host=${1:-gateway}


/usr/bin/ping -q -c3 ${host} 2>/dev/null 1> /dev/null
STATUS=$?


[ $STATUS == 0 ] && rm -f ${DB}/${NOTIFIER}_ping_${host}_${LEVEL} \
  || touch ${DB}/${NOTIFIER}_ping_${host}_${LEVEL}

exit $STATUS

