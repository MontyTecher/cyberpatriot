#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get purge wireshark wireshark-qt \
	ophcrack ophcrack-cli
sudo apt-get install ufw -y && ufw enable

mawk -F: '$1 == "sudo"' /etc/group
mawk -F: '$3 > 999 && $3 < 65534 {print $1}' /etc/passwd
mawk -F: '$2 == ""' /etc/passwd
mawk -F: '$3 == 0 && $1 != "root"' /etc/passwd

prohibited_files=`sudo find / -iname '*.mp3' 2> /dev/null`
echo $prohibited_files
rm -f $prohibited_files

