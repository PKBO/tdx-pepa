#!/bin/bash
LOG_PATH="/root/install-sh.log"
PATH="/root/tdxminer"
MINER_VERSION="v0.2.2.1"

mkdir -p $PATH
cd $PATH

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Update & Upgrade of system and installing necessary libraries"  | tee $LOG_PATH
apt-get update | tee $LOG_PATH
apt-get -y dist-upgrade | tee $LOG_PATH
apt-get -y install libnuma-dev | tee $LOG_PATH

echo "Downloading tdxminer" | tee $LOG_PATH
wget https://github.com/todxx/tdxminer/releases/download/$MINER_VERSION/tdxminer-$MINER_VERSION.tgz | tee $LOG_PATH

echo "Extracting tdxminer" | tee $LOG_PATH
tar -xf tdxminer-$MINER_VERSION.tgz | tee $LOG_PATH

echo "Performing update and Upgrade of a system" | tee $LOG_PATH
apt-get update | tee $LOG_PATH
apt-get dist-upgrade | tee $LOG_PATH
apt install libnuma-dev | tee $LOG_PATH

echo "Adding repo for rocm" | tee $LOG_PATH
wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | sudo apt-key add - | tee $LOG_PATH
echo "deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main" > /etc/apt/sources.list.d/rocm.list

echo "Instlall rocm" | tee $LOG_PATH
apt-get update >> /dev/null
apt-get -y install rocm-dkms rocm-opencl | tee $LOG_PATH
cp $PATH/tdxminer-*/tdxminer /usr/bin/tdxminer
