## This is WIP (Work in Progress)

The whole stuff here needs some clean up, more generalization, parameters and so on, but should give you a good starting
point if you are trying to build your own UEFI boot cappable Red Hat Enterprise Linux (RHEL) 7 image to run on
Hyper-V Generation 2.


## Ever wondered how to get a (custom) Gen 2 Azure image?

Given a kickstart configuration, a Red Hat Enterprise Linux (RHEL) 8 build host, but in theory everything
where you can run virt-install again a libvirtd with KVM, should be OK.

### Prerequisits (at least what I required to get this running)

* Red Hat Enterprise Linux (RHEL) 8 with the following packages
  * libvirt-client
  * virt-install
  * libvirt
  * libvirt-daemon-kvm
  * azure-cli ([1])
  * vim-enhanced
* azcopy ([2]) in the $PATH (eg. /usr/bin or ~/bin/)
* A copy of the Red Hat Enterprise Linux (RHEL) 7.7 server DVD in the following path:
  /var/lib/libvirt/images/rhel-server-7.7-x86_64-dvd.iso ([3]) [4]

### Building the VM in an automated fashion
* First, adapt kickstart.cfg as you require it
* Change the parameters in create_image.sh as you need and run the script

      # ./create_image.sh

* After the installation succeeded, the machine rebooted and you're presented with the login prompt, shut down the VM

      # virsh shutdown rhel77

* Convert the image from raw to VHD, with correct 1 MB alignment (adapt script as required)

      # ./convert_image.sh

* Create a resource group; Adapt parameters in the script and run it

      # ./group_create.sh

* Upload and 'generalize' the image; Adapt parameters and run it

      # ./upload_image.sh

* Run a VM from that newly created image; Adapt parameters and run it [5]

      # ./run_vm.sh

### Notes

* [1] Following the instructions from here:
  https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-yum?view=azure-cli-latest
* [2] Following the instructions from there:
  https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
* [3] With a valid subscription from Red Hat, you can download it here:
  https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.7/x86_64/product-software
* [4] Any other Red Hat Enterprise Linux (RHEL) 7 version should do it, but this has been tested with 7.7.
* [5] You do not need to enable boot diagnostics and if, you'll definitely have to adapt the storage account name!!!

If you're looking for creating a RHEL 8 image, have a look at this repository:
https://github.com/ofalk/azure-rhel8-gen2-vm/
