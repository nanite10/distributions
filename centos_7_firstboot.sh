#!/bin/bash

yum update -y
yum install vim rsync tmux wget iptraf-ng iperf3 nfs-utils cifs-utils -y
sed -i 's/=enforcing/=disabled/g' /etc/selinux/config
systemctl disable firewalld
service firewalld stop
