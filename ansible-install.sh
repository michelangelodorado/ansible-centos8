#!/bin/bash
echo Ansible Hostname:
read hostname
hostnamectl set-hostname $hostname
cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
sudo yum -y install epel-release
wait
sudo yum -y update
wait
#sudo reboot
sudo yum groupinstall "Development Tools" -y
wait
sudo yum install openssl-devel libffi-devel bzip2-devel wget -y
cd /
wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz
wait
tar xvf Python-3.11.0.tgz
wait
cd Python-3.11.0
./configure --enable-optimizations
wait
sudo make altinstall
wait
#python3.11 –version
#pip3.11 --version
echo 'export PATH=/usr/local/bin:$PATH' >>~/.bash_profile
adduser admin
echo admin | sudo passwd admin --stdin
sudo usermod -aG wheel admin
sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
su - admin -c 'python3.11 -m pip install --user ansible-core==2.14.2'
wait
cd /home/admin/
mkdir -p ansible/files ansible/collections ansible/playbooks ansible/roles ansible/scripts ansible/templates ansible/inventory/group_vars ansible/inventory/host_vars
chown -R admin:admin ansible
cd /home/admin/ansible/
cat << EOF | sudo tee ansible.cfg
[defaults]
inventory = ./inventory
collections_path = ./collections
roles_path = ./roles
retry_files_enabled = False
host_key_checking = False
interpreter_python = python3.11
EOF
chown -R admin:admin ansible.cfg
cd /home/admin
su admin




