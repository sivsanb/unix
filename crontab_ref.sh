#!/usr/bin
DATE=`date '%Y%m%d%H%M%S'`
#Bakup existing crontab
crontab -l > '/home/usr/cron_bkp/crontab.'${HOSTNAME}'.'${DATE}'.bkp'

#Install new cron job to run every 5 minutes
(crontab -l;echo "*/5 * * * /home/app/job.sh") | crontab -

#uninstall above cron job 
crontab -l | grep -v "/home/app.job.sh" | crontab -
