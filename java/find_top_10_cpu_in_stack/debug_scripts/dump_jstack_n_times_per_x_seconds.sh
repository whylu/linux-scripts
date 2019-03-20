#! /bin/bash

# ./dump_jstack_n_times_per_x_seconds.sh <times> <interval> <output path>



N_TIMES=$1
if [ -z "$1" ]; then
  N_TIMES=1
fi

INTERVAL=$2
if [ -z "$2" ]; then
  INTERVAL=2
fi

EXPORT_PATH=$3
if [ -z "$3" ]; then
  DATE=`date +%Y-%m-%d-%H%M%S`
  EXPORT_PATH=$(dirname $0)/dump_data/dump_jstack_${DATE}
fi

mkdir -p $EXPORT_PATH

PID=`ps aux | grep java | grep acs | head -1 | awk '{print $2}'`

echo "dump jstack to $EXPORT_PATH for $N_TIMES times per $INTERVAL seconds"

for ((a=0; a<$N_TIMES; a++))
do
  echo "dump $a..."
  top -H -bn 1 -p $PID | tail -n +8 | head -n 20 | awk '{printf("%d %d\n", $1, $9)}' > $EXPORT_PATH/top_20_id_$a
  /usr/javase/bin/jstack "$PID" > $EXPORT_PATH/dump_stack_$a
  sleep $INTERVAL;
done

