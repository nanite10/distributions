#!/bin/bash
sudo dnf config-manager --set-enabled powertools
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf update -y
sudo dnf install -y git vim ansible tmux wget net-tools cifs-utils nfs-utils bind-utils dkms kernel-devel kernel-headers gdisk
sudo cp -p /etc/issue /etc/issue.`date +%s`
sudo cp -f etc/issue /etc/issue
sudo chown root: /etc/issue
sudo chmod 0644 /etc/issue
