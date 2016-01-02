#!/bin/bash

# AUTHOR Conrad Burchert
# LICENSE public domain

if [ $# -lt 5 ]; then
	echo "Usage: "
	echo ""
	echo "$0 <name> <memory(MB)> <ssd size(MB)> <hdd size(MB)> <os> <install-iso>"
	echo ""
	echo "Use \`VBoxManage list ostypes\` to see a list of available defaults"
	echo ""
	exit 1
fi

HDDPATH="${HOME}/hdd/$1.vdi"
SSDPATH="${HOME}/VirtualBox VMs/$1/$1.vdi"

echo "Creating VM..."
VBoxManage createvm --name "$1" --ostype "$5" --register
VBoxManage modifyvm "$1" --memory "$2"
VBoxManage modifyvm "$1" --rtcuseutc on
VBoxManage modifyvm "$1" --defaultfrontend headless
VBoxManage modifyvm "$1" --autostop-type acpishutdown   # shut down VM with host

echo "Adding network interface..."
VBoxManage modifyvm "$1" --nic1 bridged
VBoxManage modifyvm "$1" --nicpromisc1 deny
VBoxManage modifyvm "$1" --bridgeadapter1 eth0

echo "Adding harddisk(sata)..."
VBoxManage storagectl "$1" --name "SATA Controller" --add sata --controller IntelAHCI

VBoxManage createhd --filename "$HDDPATH" --size "$4"
VBoxManage storageattach "$1" --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium "$HDDPATH"

if [ $3 -ne 0 ]; then
	VBoxManage createhd --filename "$SSDPATH" --size "$3"
	VBoxManage storageattach "$1" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --nonrotational on --medium "$SSDPATH"
fi

echo "Adding DVD drive(IDE)..."
VBoxManage storagectl "$1" --name "IDE Controller" --add ide
VBoxManage storageattach "$1" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$6"

echo "Enabling VNC server..."
VBoxManage modifyvm "$1" --vrde on

echo "Starting VM..."
VBoxManage startvm "$1"
