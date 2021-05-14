#!/bin/ksh
dt=`date +'%Y%m%d'`
echo "Delete files which are 30 days older in creation"
find /data/crontab_bkp -name "*.job" -type f -mtime +30 -delete

echo "Deleted older files"
crontab -l > /data/crontab_bkp/crontab_bkp_${dt}.job

echo "Script Completed"

#Schedule the job in crontab -e to run every day morning 6-30 AM and evening 7-30 PM
30 6,19 * * * /data/crontab_bkp/crontabBackup.sh


