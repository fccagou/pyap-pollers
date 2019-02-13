#!/bin/sh

PREFIX=$( cd $(dirname $0) && pwd)
DB=${DB:-${PREFIX}/current}

notifiers='local remote'

global_warns=0
global_criticals=0
global_unknowns=0
global_oks=0


for n in ${notifiers}
do
  warns=$(ls ${DB}/${n}*warn 2>/dev/null | wc -l)
  criticals=$(ls ${DB}/${n}*crit 2>/dev/null | wc -l)
  unknowns=$(ls ${DB}/${n}*unknown 2>/dev/null | wc -l)
  oks=$(ls ${DB}/${n}*ok 2>/dev/null | wc -l)

  [ $(( ${oks} + ${criticals} + ${unknowns} + ${warns} )) == 0 ] && oks=1
  
  cat > ${DB}/../$n <<EOF_STATUS
{"services":{ "ok":${oks}, "warn":${warns}, "crit":${criticals}, "unknown":${unknowns}}}
EOF_STATUS

  global_warns=$(( ${global_warns} + ${warns} ))
  global_criticals=$(( ${global_criticals} + ${criticals} ))
  global_unknowns=$(( ${global_unknowns} + ${unknowns} ))
  global_oks=$(( ${global_oks} + ${oks} ))

done


  cat > ${DB}/../global <<EOF_STATUS
{"services":{ "ok":${global_oks}, "warn":${global_warns}, "crit":${global_criticals}, "unknown":${global_unknowns}}}
EOF_STATUS


