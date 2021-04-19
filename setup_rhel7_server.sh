#!/bin/bash
sudo subscription-manager register --auto-attach
sudo subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"  --enable "rhel-ha-for-rhel-*-server-rpms"
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
sudo yum install -y git vim ansible tmux wget net-tools cifs-utils nfs-utils bind-utils dkms kernel-devel kernel-headers gdisk
sudo cp -p /etc/issue /etc/issue.`date +%s`
sudo cp -f etc/issue /etc/issue
sudo chown root: /etc/issue
sudo chmod 0644 /etc/issue
