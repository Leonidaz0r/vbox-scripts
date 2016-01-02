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

VBoxManage storageattach "$1" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium none

echo "done."
