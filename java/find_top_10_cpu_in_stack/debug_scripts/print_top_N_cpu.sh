#/bin/bash

DATE=`date +%Y-%m-%d-%H%M%S`
TMP_JSTACK=/tmp/jstack_${DATE}
JAVA_BIN=/usr/javase/bin

TOP_N=$1
if [ -z "$1" ]; then
  TOP_N=5
fi

PID=`ps aux | grep java | grep acs  | head -1 | awk '{print $2}'`

TOP_N_PID=`top -H -bn 1 -p $PID | tail -n +8 | head -n ${TOP_N} | awk '{printf("%d %d\n", $1, $9)}'`

/$JAVA_BIN/jstack "$PID" > $TMP_JSTACK


IFS=$'\n'
for TID_CPU in $TOP_N_PID
do
  TID=`echo $TID_CPU | cut -d' ' -f1`;
  CPU=`echo $TID_CPU | cut -d' ' -f2`;

  if [ $CPU -gt 0 ]
  then
    TID_HEX=`echo $TID | awk '{printf("%x ", $1)}'`
    echo $TID_CPU'%' hex=0x$TID_HEX
    grep -E $TID_HEX -A 20 $TMP_JSTACK
    echo "================================="
  fi
done

