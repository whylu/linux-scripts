#/bin/bash

JAVA_BIN=/usr/javase/bin

OUTPUT_DIR=$1
mkdir -p $OUTPUT_DIR

PID=`ps aux | grep java | grep acs | head -1 | awk '{print $2}'`

echo "dump $PID jmap heap to $OUTPUT_DIR/heap.hprof"
/$JAVA_BIN/jmap -dump:file=$OUTPUT_DIR/heap.hprof "$PID"

