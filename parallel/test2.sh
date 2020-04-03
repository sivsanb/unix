#!/bin/bash
nohup sh /Unix/parallel/test3.sh &
pr=$!
echo "PROCESS $pr"
nohup sh /Unix/parallel/test3.sh &
pr1=$!
echo "PROCESS ${pr1}"

wait ${pr}
rc1=$?
wait ${pr1}
rc2=$?

if (($rc1==0)) && (($rc2==0))
then
echo "Process $rc1 $rc2"
fi

