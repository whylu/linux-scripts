#/bin/bash

# find high cpu usage acs stack
# output file to /tmp/acs_high_cpu_stack

ACS_HIGH_CPU_OUTPUT=/tmp/acs_high_cpu_stack
PID=`ps aux | grep java | grep acs | head -1 | awk '{print $2}'`

while true; do
        sleep 1;
		TOP_20=`top -H -bn 1 -p $PID | tail -n +8 | head -n 20 | awk '{printf("%d %d\n", $1, $9)}'`
        /usr/javase/bin/jstack "$PID" > /tmp/acs_dump_find_high_cpu_acs_task


        IFS=$'\n'
        for TID_CPU in $TOP_20
        do
          TID=`echo $TID_CPU | cut -d' ' -f1`;
          CPU=`echo $TID_CPU | cut -d' ' -f2`;

          if [ $CPU -gt 0 ]
          then
            echo $TID_CPU'%';
            TID_HEX=`echo $TID | awk '{printf("%x ", $1)}'`
            SOMETHIG=`grep -E $TID_HEX -A 20 /tmp/acs_dump_find_high_cpu_acs_task | grep -E '.*\.acs\..*' -A 10 -B 10`
            if [[ ! -z $SOMETHIG ]]
            then
                echo $TID_CPU'%' >> "$ACS_HIGH_CPU_OUTPUT";
                grep -E $TID_HEX -A 20 /tmp/acs_dump_find_high_cpu_acs_task | grep -E '.*\.acs\..*' -A 10 -B 10 >> "$ACS_HIGH_CPU_OUTPUT"
                grep -E $TID_HEX -A 20 /tmp/acs_dump_find_high_cpu_acs_task | grep -E '.*\.acs\..*' -A 10 -B 10
                echo "------------" >> "$ACS_HIGH_CPU_OUTPUT"
            fi
            echo "------"
          fi
        # echo $TID
        # echo $CPU
        done
        echo $TOP_20

done
