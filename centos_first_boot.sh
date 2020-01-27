#!/bin/bash
full=`cat /etc/centos-release | tr -dc '0-9.'`
major=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f1)
minor=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f2)
asynchronous=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f3)

echo "CentOS Version: $full"
echo "Major Relase: $major"
echo "Minor Relase: $minor"
echo "Asynchronous Relase: $asynchronous"

if [[ "$major" == "7" ]]; then
  yum update -y
  yum install vim rsync tmux wget iptraf-ng iperf3 nfs-utils cifs-utils epel-release -y
  yum update -y
  sed -i 's/=enforcing/=disabled/g' /etc/selinux/config
  systemctl disable firewalld
  service firewalld stop
elif [[ "$major" == "8" ]]; then
  dnf update -y
  dnf install vim rsync tmux wget iptraf-ng iperf3 nfs-utils cifs-utils epel-release -y
  dnf update -y
  sed -i 's/=enforcing/=disabled/g' /etc/selinux/config
  systemctl disable firewalld
  service firewalld stop
fi
