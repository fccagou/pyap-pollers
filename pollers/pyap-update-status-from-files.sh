#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}

notifiers='local remote'

for n in ${notifiers}
do
  warns=$(ls ${DB}/${n}*warn 2>/dev/null | wc -l)
  criticals=$(ls ${DB}/${n}*crit 2>/dev/null | wc -l)
  unknowns=$(ls ${DB}/${n}*unknown 2>/dev/null | wc -l)
  oks=$(ls ${DB}/${n}*ok 2>/dev/null | wc -l)

  [ "$oks" == "0" ] && oks=1
  
  cat > ${DB}/../$n <<EOF_STATUS
{"services":{ "ok":${oks}, "warn":${warns}, "crit":${criticals}, "unknown":${unknowns}}}
EOF_STATUS

done


