# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure. 

![alt text](https://github.com/taofeekaoyusuf/azurewebserver-deploymenr-with-terraform-and-packer-in-azurecloud/blob/main/project1_image.png)


### Introduction

In this project, a Packer and a Terraform templates were create to deploy a customizable, and scalable Web Server on Microsoft Azure Cloud Platform.

### Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions for running the Packer and Terraform templates

**In order to initialize the infrastructure, there are two scenarios:**

- You can start the building of the Infrastructure by either running the Policy, Packer, and Terraform codes on Azure Cloud CLI, or
- Off the Azure Cloud CLI.
- Whichever the case maybe, ensure to select the number of Virtual Machines `(VM)` you intend creating by modifying the `count_on` variable in the `variables.tf` file.
- **NOTE:** The highest number of Virtual Machines that can be specified is 3, in this scenario as we are limited by the resources provided to us by Udacity.
- If you intend to run this code on your own Microsoft Azure's account, then you can feel free to experiment with more than 3 VMs.

**For `Scenario one`**

- Initiate the Infrastructural build with this comman: `sh azure_starter_and_policy.sh` and press Enter key.

**For `Scenario two`**

- Open the `azure_starter_and_policy.sh` bash script file and uncomment the `Login Section` of the file and specify the parameters as requested by the code before running the command, and once that is accomplished, you can then initiate the infrastructure building like specified in `Scenario one`.

To have further insight on how the Packer and Terraform commands were initiated, kindly checkout the `azure_starter_and_policy.sh` bash script file for details, please. And in order to clean-up after building the infrastructures and creating different resources, kindly refer to the `Clean-up and Maintenance` section of this README file.

**Clean-up and Maintenance**

- When all is done and set, the resources created can be deleted and destroyed by running the bash script file named `cleanUp_and_maintenance.sh` thus: `sh cleanUp_and_maintenance.sh`.
- This operation will delete and destroy all the created resources after we are done with it.

**That's all in a nutshell, Enjoy!!!**

### Outputs

- **main.tf**
- **variables.tf**
- **server.json**
- **requested snapshots**
- **solution.plan**
- **Other useful files**
