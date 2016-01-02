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

VBoxManage modifyvm "$1" --vrde on

echo "done."
