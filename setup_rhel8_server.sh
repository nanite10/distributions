#!/bin/bash
subscription-manager register --auto-attach
subscription-manager repos --enable "codeready-builder-for-rhel-8-x86_64-rpms"
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf update -y
dnf install -y git vim ansible tmux wget net-tools cifs-utils nfs-utils bind-utils dkms kernel-devel kernel-headers gdisk
