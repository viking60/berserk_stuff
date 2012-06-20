#!/bin/bash
cd /home/<your_name>
for i in `cat viking.backup`; 
do rsync -azrvv --delete --delete-excluded  --exclude-from 'ex.txt'  $i /media/MyHD/My_backup/; 
done
