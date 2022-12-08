# ansible-centos8
steps and commands to deploy ansible in centos8


cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
sudo yum -y install epel-release
sudo yum -y update
sudo reboot
sudo yum groupinstall "Development Tools" -y sudo yum install openssl-devel libffi-devel bzip2-devel –y
sudo yum install wget –y
cd /
wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz
tar xvf Python-3.11.0.tgz
cd Python-3.11.0
./configure --enable-optimizations
sudo make altinstall
python3.11 –version
pip3.11 --version
python3.11 -m pip install --user ansible-core==2.14.0
/home/admin/.local/lib/python3.11/site-packages/ansible
