#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}
notifier='local'

yum clean all 2>&1 > /dev/null
yum check-update -q >/dev/null

STATUS=$?

case ${STATUS} in
    100)
	touch ${DB}/${notifier}_sysupgrade_warn
	# TDO: ajouter un délai pour passer en rouge
	;;
     1)
	touch ${DB}/${notifier}_sysupgrade_unknown
	;;
     0)
	rm  -f ${DB}/${notifier}_sysupgrade*
        ;;
esac

exit ${STATUS}

