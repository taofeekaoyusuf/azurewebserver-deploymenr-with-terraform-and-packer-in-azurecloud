#!/bin/bash

# Deleting Images created using Packer
az image delete -g Azuredevops -n myPackerImage
az image delete -g Azuredevops -n myPackervmImage

# Deleting Images created using Terraform
terraform destroy
