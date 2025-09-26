#!/bin/bash

[ -e './log' ] && rm -f log

apt-get update -y && apt-get upgrade -y
apt-get purge wireshark-qt wireshark ophcrack
apt-get install ufw -y && ufw enable

sed -i 's/\(pam_pwquality.so\).*$/\1 minlen=14/' /etc/pam.d/common-password
sed -i 's/nullok//' /etc/pam.d/common-auth
sed -i "s/^\(PASS_MAX_DAYS\).*$/\1\t30/" /etc/login.defs
sed -i "s/PermitRootLogin no//" /etc/ssh/ssh_config
echo "PermitRootLogin no" >> /etc/ssh/ssh_config

find /home -type f \( -name "*.tar.gz" -o -name "*.tgz" -o -name "*.zip" -o -name "*.deb" -o -name "*.mp3" -o -name "*.mp4" \) >> ./log
mawk -F: '$1 == "sudo"' /etc/group >> ./log

chmod 600 /etc/shadow
chmod 640 /boot/grub/grub.cfg
chmod -R 600 /etc/sudoers.d

apt-get install lynis && lynis audit system
