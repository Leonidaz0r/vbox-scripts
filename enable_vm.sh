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

echo "Enabling autostart on boot..."
VBoxManage modifyvm "$1" --autostart-enabled on
VBoxManage startvm "$1"

echo "done."
