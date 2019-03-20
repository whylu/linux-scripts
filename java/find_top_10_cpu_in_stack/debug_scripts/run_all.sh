#!/bin/bash

BASE_DIR=$(dirname $0)
if [ $BASE_DIR == "." ]; then
  BASE_DIR=$(pwd)
fi

DATE=`date +%Y-%m-%d-%H%M%S`
OUTPUT_DIR=$BASE_DIR/dump_data/$DATE

echo "output data to: $OUTPUT_DIR"
mkdir -p $OUTPUT_DIR


N_TIMES=10
INTERVAL=2
echo "run /$BASE_DIR/dump_jstack_n_times_per_x_seconds.sh $N_TIMES $INTERVAL $OUTPUT_DIR/dump_jstack_${N_TIMES}_per_${INTERVAL}_seconds ..."
/$BASE_DIR/dump_jstack_n_times_per_x_seconds.sh $N_TIMES $INTERVAL $OUTPUT_DIR/dump_jstack_${N_TIMES}_per_${INTERVAL}_seconds

echo "dump jmap heap"
/$BASE_DIR/dump_jmap_heap.sh $OUTPUT_DIR/dump_jmap_heap

echo "top N CPU..."
/$BASE_DIR/dump_top_N_cpu_X_times.sh 10 10 $OUTPUT_DIR/top_N_cpu


echo "Compressing.."
tar zcvf $OUTPUT_DIR.tar.gz $OUTPUT_DIR
if [ -f $OUTPUT_DIR.tar.gz ]; then
    echo "Compress success: $OUTPUT_DIR.tar.gz"
    if [ -d $OUTPUT_DIR ]; then
        echo "remove folder: $OUTPUT_DIR"
        rm -rf $OUTPUT_DIR
    fi
fi


echo "===="
df -h $BASE_DIR

