PID=`ps aux --sort=start_time | grep java | head -1 | awk '{print $2}'`

ps -mp $PID -o THREAD,tid,time | sort -k 2 -r | head -20


echo -n -e " shur ru:"

read f


if [ -z $f ]

then

echo "no"

else

/usr/javase/bin/jstack "$PID" | grep `printf "%x\n" $f` -A 50

fi
