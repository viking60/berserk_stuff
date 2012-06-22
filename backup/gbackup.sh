#!/bin/bash
#Setting up some colors I might use later here:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m' # No Color
echo -e "Hi, please type $CYAN/home/<your name>$NC here (your home directory): \c "
read  hjem
echo -e "Hi, please type the $CYAN/full/path/to_the target/$NC here (where your backup will be stored): \c "
read maal
cd $hjem   
# checking if ex.txt exists
if [ -e 'ex.txt' ]
then
echo "ex.txt exists"
else
#Creating ex.txt and populating it with /home/<my_name>/.gvfs to avoid errors when running as root
echo '#Here you can put the all the files and directories you do not want to backup. Like the example below:'>>ex.txt
echo '*/.gvfs'>>ex.txt
echo "ex.txt has been created"
fi
#Creating viking.backup and populating it with the home directory and /etc (must run as root!)
if [ -e 'viking.backup' ]
then
echo "viking.backup exists"
else
echo $hjem>>viking.backup #Creates viking.backup and putting </home/your_name> in there 
echo '/etc'>>viking.backup #adding the /etc directory to be backed up 
fi
#The Magic happens! 
for i in `cat viking.backup`; 
do rsync -azrv --delete --delete-excluded  --exclude-from 'ex.txt'  $i $maal; 
#Creating a log (backup.log) to se when the last backup was run - nice when checking cron jobs 
echo -n 'Last backup at the bottom:'>>backup.log|date +'%d-%m-%Y klokken %H:%M'>>backup.log
done
#Viking says roar!!!
