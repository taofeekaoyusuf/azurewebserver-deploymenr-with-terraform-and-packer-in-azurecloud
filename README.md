# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
In this project, a Packer and a Terraform template were create to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
**In order to initialize the infrastructure, there are two scenarios:**
- Either you wish to run the infrastructure on Azure Cloud CLI, or
- Off the Azure Cloud CLI.

**For Scenario one**
- Initiate the Infrastructural build with this comman: `sh azure_starter_and_policy.sh` and press Enter key.

**For Scenario two**
- Open the `azure_starter_and_policy.sh` bash script file and uncomment the `Login Section` of the file, and after which you can initiate the infrastructure building as specified in `Scenario one`.

**Clean up and Maintenance**
- When all is done and set, the resources created can be deleted and destroyed by running the bash script file named `cleanUp_and_maintenance.sh` thus: `sh cleanUp_and_maintenance.sh`.
- This operation will delete and destroy all the created resources after we are done with it.

**That's all in a nutshell, Enjoy!!!**

### Output
- **main.tf**
- **variables.tf**
- **server.json**
- **requested snapshots**
- **solution.plan**
- **other files**
