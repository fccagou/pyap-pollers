#!/bin/sh

POLLERS_DIR="${POLLERS_DIR:-$(dirname $0)/../pollers}"
cd "${POLLERS_DIR}"

# Collect all status
./check_local_disks.sh
./check_local_yumupdate.sh
./check_local_raid.sh /dev/md0

./check_remote_ping.sh gateway crit remote

if [ $? == 0 ]
then
  # Got network, we can use remote pollers.
  ./check_remote_syslog.sh
  ./check_remote_dns.sh
fi

# Update pyap status
./pyap-update-status-from-files.sh


