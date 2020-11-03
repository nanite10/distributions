#!/bin/bash
full=`cat /etc/centos-release | tr -dc '0-9.'`
major=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f1)
minor=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f2)
asynchronous=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f3)

echo "CentOS Version: $full"
echo "Major Relase: $major"
echo "Minor Relase: $minor"
echo "Asynchronous Relase: $asynchronous"

# Update system and install common packages
if [[ "$major" == "7" ]]; then
  yum update -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  yum install epel-release -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  yum update -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  yum install vim rsync tmux wget iptraf-ng iperf3 cifs-utils git glusterfs-client kernel-headers-$(uname -r) kernel-devel-$(uname -r) ncurses-devel flex bison openssl openssl-devel dkms elfutils-libelf-devel autoconf bzip2 automake libtool libuuid-devel libblkid-devel rpm-build libudev-devel libattr-devel libaio-devel python2-devel python-cffi python-setuptools libffi-devel cyrus-sasl-plain mailx strace mdadm lvm2 sysstat lm_sensors-libs net-tools sshpass samba -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  yum update -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
elif [[ "$major" == "8" ]]; then
  dnf update -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  dnf install epel-release -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  dnf update -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  dnf install vim rsync tmux wget iptraf-ng iperf3 cifs-utils git glusterfs-client kernel-headers-$(uname -r) kernel-devel-$(uname -r) ncurses-devel flex bison openssl openssl-devel dkms elfutils-libelf-devel autoconf bzip2 automake libtool libuuid-devel libblkid-devel rpm-build libudev-devel libattr-devel libaio-devel libtirpc-devel python2-devel libffi-devel cyrus-sasl-plain mailx strace mdadm lvm2 sysstat lm_sensors-libs net-tools sshpass samba -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
  dnf update -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
fi

sed -i 's/=enforcing/=disabled/g' /etc/selinux/config
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl disable firewalld
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
service firewalld stop
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi

# Install ZFS
wget https://github.com/zfsonlinux/zfs/releases/download/zfs-0.8.5/zfs-0.8.5.tar.gz
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
tar -xvzf zfs-0.8.5.tar.gz
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
cd zfs-0.8.5
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
sh autogen.sh
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
./configure
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
make
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
make rpm
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
if [[ "$major" == "7" ]]; then
  yum install zfs-dkms-0.8.5-1.el7.src.rpm zfs-dkms-0.8.5-1.el7.noarch.rpm zfs-0.8.5-1.el7.src.rpm python2-pyzfs-0.8.5-1.el7.noarch.rpm zfs-dracut-0.8.5-1.el7.noarch.rpm libnvpair1-0.8.5-1.el7.x86_64.rpm libuutil1-0.8.5-1.el7.x86_64.rpm libzfs2-0.8.5-1.el7.x86_64.rpm libzfs2-devel-0.8.5-1.el7.x86_64.rpm libzpool2-0.8.5-1.el7.x86_64.rpm zfs-0.8.5-1.el7.x86_64.rpm zfs-debuginfo-0.8.5-1.el7.x86_64.rpm -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
elif [[ "$major" == "8" ]]; then
  dnf install zfs-dkms-0.8.5-1.el7.src.rpm zfs-dkms-0.8.5-1.el7.noarch.rpm zfs-0.8.5-1.el7.src.rpm python2-pyzfs-0.8.5-1.el7.noarch.rpm zfs-dracut-0.8.5-1.el7.noarch.rpm libnvpair1-0.8.5-1.el7.x86_64.rpm libuutil1-0.8.5-1.el7.x86_64.rpm libzfs2-0.8.5-1.el7.x86_64.rpm libzfs2-devel-0.8.5-1.el7.x86_64.rpm libzpool2-0.8.5-1.el7.x86_64.rpm zfs-0.8.5-1.el7.x86_64.rpm zfs-debuginfo-0.8.5-1.el7.x86_64.rpm -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
fi
modprobe zfs
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-import-scan.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
echo "zfs" > /etc/modules-load.d/zfs.conf
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
grub_file=`find /boot -type f -name grub.cfg`
if [ -z "$grub_file" ]; then echo "ERROR: Failed to find grub.cfg in /boot"; exit 1; fi
depmod -a
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
dracut -f
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
grub2-mkconfig -o "$grub_file"
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi

# Install lsyncd
if [[ "$major" == "7" ]]; then
  yum install cmake lua lua-devel gcc-c++ -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
elif [[ "$major" == "8" ]]; then
  dnf install cmake lua lua-devel gcc-c++ -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
fi
git clone https://github.com/axkibe/lsyncd.git
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
cd lsyncd
mkdir build
cd build
cmake ..
make
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
cp lsyncd /usr/local/sbin/
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
echo "fs.inotify.max_user_watches = 16777216" >> /etc/sysctl.conf
echo "fs.inotify.max_queued_events = 1000000" >> /etc/sysctl.conf
sysctl fs.inotify.max_user_watches=16777216
sysctl fs.inotify.max_queued_events=1000000

# Install updated rsync
if [[ "$major" == "7" ]]; then
  yum install gcc gawk autoconf automake acl libacl-devel attr libattr-devel openssl-devel lz4 lz4-devel -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
elif [[ "$major" == "8" ]]; then
  dnf install gcc gawk autoconf automake acl libacl-devel attr libattr-devel openssl-devel lz4 lz4-devel -y
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
fi
wget https://download.samba.org/pub/rsync/src/rsync-3.2.3.tar.gz
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
tar -xvzf rsync-3.2.3.tar.gz
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
cd rsync-3.2.3
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
./configure --disable-xxhash --disable-zstd --enable-acl-support --disable-md2man
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
make
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
cp rsync /usr/local/sbin/
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
