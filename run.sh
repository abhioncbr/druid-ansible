#! /bin/bash
cd terraform

# only terraform pull if not using local state
if [ $(grep local *backend.tf | wc -l) -eq 0 ]
  then terraform state pull > terraform.tfstate
fi

cd ..
TF_STATE=terraform/terraform.tfstate ansible-playbook -i $(which terraform-inventory) $1
