variable "hack-rg" {
  description = "The name of the resource group in which to create other Azure resources."
  default     = "Azuredevops"
}

variable "hack-vnet" {
  description = "The virtual network handle for vnet resources."
  default     = "hack-vnet"
}

variable "hack-subnet" {
  description = "The subnet network handle for vnet resources."
  default     = "hack-subnet"
}

variable "name" {
  description = "The name variable for resources."
  default     = "azure"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "southcentralus"
}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
  default     = "linux"
}

variable "hack-dns" {
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = "hack-dns"
}

variable "lb_ip_dns_name" {
  description = "DNS for Load Balancer IP"
  default     = "hack-dns-load_balancer"
}

variable "hack-addpool" {
  description = "The name for the network backend ip pool association resources."
  default     = "hack-addpool"
}

variable "hack-nic" {
  description = "The name for the network interface resources."
  default     = "hack-nic"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "packer-vm-image" {
  description = "The VM-image generated by Packer"
  default     = "myPackerVMImage"
}

variable "storage_account_tier" {
  description = "Defines the Tier of storage account to be created. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the Replication Type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_DS1_v2"
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "count_on" {
  description = "Allows the User to specify the number of VM resources"
  default     = "3"
}

variable "username" {
  description = "administrator user name"
  default     = "hackuser"
}

variable "password" {
  description = "administrator password (recommended to disable password auth)"
  default     = "password"
}
