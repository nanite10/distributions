rm -f /etc/apt/sources.list.d/pve-enterprise.list
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-community.list
sudo apt update -y
sudo apt upgrade -y
sudo apt install autoconf automake bison bzip2 cifs-utils dkms libelf-dev flex git glusterfs-client iperf3 iptraf-ng libaio-dev libattr1-dev libblkid-dev libelf-dev libffi-dev libiberty-dev libncurses-dev libpci-dev libssl-dev libtool libudev-dev libudev-dev uuid-dev lvm2 bsd-mailx mdadm ncurses-dev net-tools openssl libssl-dev python2-dev python-cffi python-setuptools rsync sshpass strace sysstat tmux vim wget pve-headers-$(uname -r) linux-cpupower -y
