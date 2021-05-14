#!/usr/bin/bash
source /home/usr/.bash_profile
jobPATH=/data/Scripts/<processNM>

#Remove Temporary Files
rm -f $jobPATH/<processNM>.log

#Initialize 
fail=0

echo "Kafka Broker Status Report" >> $jobPATH/<processNM>.log
echo "==========================" >> $jobPATH/<processNM>.log
listKAFKABROKERS=host1,host2,host3
IFS=","
for hostNM in $listKAFKABROKERS;
do
if nc -zv ${hostNM}-company.com port
then
echo "KAFKA Broker $hostNM is Up and Running" >> $jobPATH/<processNM>.log
else
echo "KAFKA Broker $hostNM is DOWN !!!" >> $jobPATH/<processNM>.log
fail=$(expr $fail + 1)
fi
done
echo "+++++++++++++++++++++++++++" >> $jobPATH/<processNM>.log

#Check for Overall YARN Cluster Jobs Que Status
echo "YARN Que Load Status " >> $jobPATH/<processNM>.log

mapred queue -list >> $jobPATH/<processNM>.log

if [ $fail -eq 0 ]; then
mailx -s "Sucess Alert Subject: Kafka and Yarn Status " -r sender@123.com reciever1@123.com,reciever2@123.com < $jobPATH/<processNM>.log
else
mailx -s "Failed Alert Subject: Kafka and Yarn Status " -r sender@123.com reciever1@123.com,reciever2@123.com < $jobPATH/<processNM>.log
fi
