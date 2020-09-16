#!/bin/bash
sudo swupd bundle-add os-core-search os-core-dev linux-dev vim rsync wget tmux net-tools network-basic git
wget https://github.com/openzfs/zfs/releases/download/zfs-2.0.0-rc1/zfs-2.0.0-rc1.tar.gz
tar -xvzf zfs-2.0.0-rc1.tar.gz
cd zfs-2.0.0
sh autogen.sh
./configure
make -s
sudo make install
modprobe zfs

systemctl enable zfs-import-cache.service
systemctl enable zfs-import-scan.service
systemctl enable zfs-mount.service
systemctl enable zfs-share.service
systemctl enable zfs-volume-wait.service
systemctl enable zfs-zed.service
systemctl enable zfs-import.target
systemctl enable zfs-volumes.target
systemctl enable zfs.target

sudo mkdir -p /etc/kernel/cmdline.d
echo "module.sig_unenforce" | sudo tee /etc/kernel/cmdline.d/allow-unsigned-modules.conf
sudo mkdir -p /etc/modprobe.d
sudo mkdir -p /etc/modules-load.d
echo "zfs" | sudo tee /etc/modules-load.d/zfs.conf
sudo clr-boot-manager update
#Reboot
