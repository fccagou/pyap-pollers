#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}
NOTIFIER='remote'
LEVEL='crit'

PRIMARY_NSNAME="${1}"
SECONDARY_NSNAME="${2}"

shift; shift;

DNS_SRV="${@}"


for s in ${DNS_SRV}
do

  if host ${PRIMARY_NSNAME} ${s} > /dev/null && host ${SECONDARY_NSNAME} ${s} > /dev/null 
  then
     rm -f ${DB}/remote_dns_${s}_${LEVEL}
  else
     touch ${DB}/remote_dns_${s}_${LEVEL}
  fi
  
done

