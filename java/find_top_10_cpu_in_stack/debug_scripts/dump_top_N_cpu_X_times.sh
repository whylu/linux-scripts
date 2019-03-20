#!/bin/bash
# ./dump_top_N_cpu_X_times.sh [TOP_N] [N_TIMES] [EXPORT_PATH]

BASE_DIR=$(dirname $0)
if [ $BASE_DIR == "." ]; then
  BASE_DIR=$(pwd)
fi

TOP_N=$1
if [ -z "$1" ]; then
  TOP_N=5
fi

N_TIMES=$2
if [ -z "$2" ]; then
  N_TIMES=1
fi


EXPORT_PATH=$3
if [ -z "$3" ]; then
  DATE=`date +%Y-%m-%d-%H%M%S`
  EXPORT_PATH=$BASE_DIR/dump_data/dump_topN_CPU_${DATE}
fi
mkdir -p $EXPORT_PATH

INTERVAL=2


echo "dump top $TOP_N CPU to $EXPORT_PATH for $N_TIMES times per $INTERVAL seconds"


for ((a=0; a<$N_TIMES; a++))
do
  echo "dump top cpu -  $a..."
  /$BASE_DIR/print_top_N_cpu.sh $TOP_N > $EXPORT_PATH/top_N_cpu_$a
  sleep $INTERVAL;
done

