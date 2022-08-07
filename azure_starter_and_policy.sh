#! /bin/bash


### === CODE EXECUTION STARTS HERE === ###

echo "\n*****### TERRAFORM PROJECT: Deploying Webserver on Microsoft Azure Cloud with Terraform and Packer ###*****\n"
sleep 2

echo "\n***### Welcome to Web Server Deployment Project ###***\n"
sleep 2

echo "\n***### Microsoft Azure Cloud Platform Login with Service Principal Enables ###***\n"
sleep 2



### === AZURE LOGIN === ###

# Microsoft Azure Cloud Platform Login with Service Principal Enables
# echo "\n***### Login to Microsoft Azure Cloud Platform ###***"
# sleep 5
# az login
# sleep 5
# az account set --subscription="#specify_subscription_id"
# sleep 5
# az ad sp create-for-rbac -n "hackApp" --role Contributor --scopes /subscriptions/#specify_subscription_id/resourceGroups/Azuredevops
# sleep 5
# az login --service-principal -u #specify_client_id -p #specify_client_secret --tenant #specify_tenant_id
# echo "\n***### End of Login to Microsoft Azure Cloud Platform ###***"
# sleep 5



### === AZURE VM CREATION FROM CLI === ###

# echo "\n*** Virtual Machine Creation on Azure Cloud Platform ***"
# sleep 2
# Virtual Machine Creation
# az vm create --resource-group #specify-rg-name --name #specify-VM-name --image #specify-VM-type --generate-ssh-keys --output json --verbose
# echo "\n*** End of Virtual Machine Creation on Azure Cloud Platform ***"
# sleep 5



### === POLICY DEFINITION AND ASSIGNMENT === ###

echo "\n***### Policy Definition on Azure Cloud Platform ###***"
sleep 2
# Policy Definition
az policy definition create --name tagging-policy --rules azure-tag-policy.json
echo "\n***### End of Policy Definition on Azure Cloud Platform ###***"
sleep 5

echo "\n***### Policy Assignment on Azure Cloud Platform ###***\n"
sleep 2
# Policy Assignment
az policy assignment create --policy tagging-policy --name tagging-policy
echo "\n***### End of Policy Assignment on Azure Cloud Platform ###***\n"
sleep 5

echo "\n***### Policy Assignment Listing ###***\n"
sleep 2
# Policy Assignment Listing
az policy assignment list
echo "\n***### End of Policy Assignment Listing ###***\n"
sleep 15



### === PACKER IMAGE CREATION === ### 

# echo "\n***### Upgrading the Packer JSON Config to HCL ###***\n"
# sleep 2
# # Upgrade Packer JSON Config
# packer hcl2_upgrade -with-annotations server.json
# echo "\n***### End of Packer JSON Config to HCL upgrade ###***\n"
# sleep 5

echo "\n***### Formatting Packer Configurations ###***\n"
sleep 2
# Packer Config Formatting
packer fmt .
echo "\n***### End of Packer Configurations Formatting ###***\n"
sleep 5

echo "\n***### Initializing Packer Configurations ###***\n"
sleep 2
# Packer Config Initialization
packer init .
echo "\n***### End of Packer Configurations Initialization ###***\n"
sleep 5

echo "\n***### Validating Packer Configurations ###***\n"
sleep 2
# Packer Config Validation
packer validate .
echo "\n***### End of Packer Configurations Validation ###***\n"
sleep 5

echo "\n***### Building Packer Image ###***\n"
sleep 2
# Packer Image Building
packer build server.json.pkr.hcl
echo "\n***### End of Packer Image Building ###***\n"
sleep 5



### === SSH KEY GENERATION === ###

echo "\n***### SSH Key Generation ###***\n"
sleep 2
# Creating SSH Key Generation
echo "\n***### When prompted for a Passphrase input, press ENTER key twice. ###***\n"
sleep 2
ssh-keygen -t rsa -b 4096 -f id_rsa
echo "\n***### End of SSH Key Generation ###***\n"
sleep 5



### === TERRAFORM === ###

echo "\n***### Formating the Terraform files ###***\n"
sleep 2
# Terraform Formating
terraform fmt .
echo "\n***### End of Terraform files Formating ###***\n"
sleep 5

echo "\n***### Initializing Terraform ###***\n"
sleep 2
# Terraform initialization
terraform init
echo "\n***### End of Terraform Initialization ###***\n"
sleep 5

echo "\n***### Validating the Terraform files ###***\n"
sleep 2
# Terraform Formating
terraform validate .
echo "\n***### End of  Terraform files Validation ###***\n"
sleep 5

echo "\n***### Terraform Plan Execution ###***\n"
sleep 2
# Terraform Planning
terraform plan -out solution.plan
echo "\n***### End of Terraform Plan Execution ###***\n"
sleep 5

echo "\n***### Terraform Apply Operation ###***\n"
sleep 2
# Terraform Apply Operation
terraform apply "solution.plan"   # terraform-config.json
echo "\n***### End of Terraform Apply Operation ###***\n"
sleep 5

echo "\n***### Azure Resource State Listing ###***\n"
sleep 2
# Listing all the resources created so far
terraform state list
sleep 5
echo "\n***### End of Azure Resource State Listing ###***\n"
