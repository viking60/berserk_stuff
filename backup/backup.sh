#!/bin/bash
if [ -e 'ex.txt' ]
then
echo "ex.txt exists"
else
echo '#Here you can put the all the files and directories you do not want to backup. Like the example below:'>>ex.txt
echo '*/.gvfs'>>ex.txt
echo "ex.txt has been created"
fi
if [ -e 'viking.backup' ]
then
echo "viking.backup exists"
else
echo '#Here you can put the all the files and directories you want to backup'>>viking.backup
fi
cd /home/<USER> # Fill in your data ~/ will not work with sudo
for i in `cat viking.backup`;
do rsync -azrv --delete --delete-excluded  --exclude-from 'ex.txt'  $i /media/<your media>/<your path>/;#put you backup media in here
echo -n 'The last backup at the bottom:'>>backup.log|date +'%d-%m-%Y Time %H:%M'>>backup.log
done
