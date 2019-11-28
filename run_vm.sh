az storage account create -n lkernatstor -g myresourcegroup -l westus2 --sku Standard_LRS

az vm create  \
    --resource-group myresourcegroup \
    --location westus2 \
    --name rhel-7 \
    --image rhel-7 \
    --boot-diagnostics-storage lkernatstor \
    --admin-username cloud-user \
    --ssh-key-value @/root/.ssh/id_rsa.pub
