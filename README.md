# Virtual Box easy VM management

## Setup of a new VM

Use

    VBoxManage list ostypes

and find your os type name. Prepare an installation iso of your operating system and use the following command to create a virtual machine.

    ./scripts/create_vm.sh <name> <memory(MB)> <ssd size(MB)> <hdd size(MB)> <os> <install-iso>

The VM will start with VNC enabled. Connect on the default VNC port to the host to run the installer.

After finishing the installation and setting up ssh shut down the VM and run:

    ./scripts/disable_vrde.sh <name>
    ./scripts/eject_medium.sh <name>
    ./scripts/enable_vm.sh <name>

This will eject the installation iso, disable the VNC server and configure automatic start and shutdown at host reboot.
