#!/bin/bash

# AUTHOR Conrad Burchert
# LICENSE public domain

if [ $# -lt 1 ]; then
        echo "Usage: "
        echo ""
        echo "$0 <name>"
        echo ""
        exit 1
fi

isrunning() {
	VBoxManage list runningvms | grep --quiet "$1"
	return $?
}

echo "Disabling autostart on boot..."
VBoxManage modifyvm "$1" --autostart-enabled off
VBoxManage controlvm "$1" acpipowerbutton

echo -n "Waiting for shutdown... (You can use CTRL-C and wait for yourself)"
while isrunning "$1"
do
	echo -n .
	sleep 1
done
echo ""
echo "Shutdown complete"
