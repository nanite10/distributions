#!/bin/bash
apt update -y
apt upgrade -y
apt install git vim ansible tmux wget net-tools smbclient libnfs-utils net-tools dkms pve-headers-$(uname -r) gdisk sudo
