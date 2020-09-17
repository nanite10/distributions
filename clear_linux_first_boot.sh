#!/bin/bash
sudo swupd bundle-add os-core-search os-core-dev linux-dev vim rsync wget tmux net-tools network-basic git
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
wget https://github.com/openzfs/zfs/releases/download/zfs-2.0.0-rc1/zfs-2.0.0-rc1.tar.gz
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
tar -xvzf zfs-2.0.0-rc1.tar.gz
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
cd zfs-2.0.0
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
sh autogen.sh
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
./configure
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
make -s
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
sudo make install
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
modprobe zfs
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi

systemctl enable zfs-import-cache.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-import-scan.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-mount.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-share.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-volume-wait.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-zed.service
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-import.target
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs-volumes.target
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
systemctl enable zfs.target
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi

sudo mkdir -p /etc/kernel/cmdline.d
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
if ! grep -q "module.sig_unenforce" /etc/kernel/cmdline.d/allow-unsigned-modules.conf; then
  echo "module.sig_unenforce" | sudo tee /etc/kernel/cmdline.d/allow-unsigned-modules.conf
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
fi
sudo mkdir -p /etc/modprobe.d
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
sudo mkdir -p /etc/modules-load.d
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
if ! grep -q "zfs" /etc/modules-load.d/zfs.conf; then
  echo "zfs" | sudo tee /etc/modules-load.d/zfs.conf
  if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
fi
depmod -a
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
sudo clr-boot-manager update
if [ $? -ne 0 ]; then echo "ERROR: Failure on last command; run was ["!:0"] with arguments ["!:*"]"; exit 1; fi
#Reboot
echo "Ready for reboot!"
