#!/bin/bash
# update and upgrade system 
apt update && sudo apt upgrade -y 
# create folder for restic backup password file 
mkdir /home/steve/.credentials
# print line and continue once file has been pasted in to the correct directory 
read -p 'make sure to copy file "hetznercredentials" to /home/steve/.credentials/ | Press any key to resume ...'
# add ansible ppa | check https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html for mor information 
sudo apt install software-properties-common -y 
sudo add-apt-repository --yes --update ppa:ansible/ansible
# install ansible and curl 
sudo apt install ansible curl -y # install ansible 
# 2.install necesarry Software with ansible playbook 
ansible-playbook installclient.yml -K
# mnt restic backup 
restic -r sftp://u383520-sub1@u383520.your-storagebox.de:/Restic-Backup-Nextcloud mount /home/steve/resticmnt --verbose --password-file /home/steve/.credentials/hetznercredentials
