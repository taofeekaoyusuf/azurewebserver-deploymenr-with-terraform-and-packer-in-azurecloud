output "name" {
  value = data.azurerm_resource_group.hack-rg.name
}

output "location" {
  value = data.azurerm_resource_group.hack-rg.location
}

output "public_ip_address" {
  value = "${length(azurerm_linux_virtual_machine.hack-vm)}: ${data.azurerm_public_ip.hack-pub-ip-data.ip_address}"
}

output "image_id" {
  value = "/subscriptions/0173e877-ea67-406c-b540-ed9828abafea/resourceGroups/RG-EASTUS-SPT-PLATFORM/providers/Microsoft.Compute/images/myPackerVMImage"
}

output "hostname" {
  value = var.hostname
}

output "vm_fqdn" {
  value = data.azurerm_public_ip.hack-pub-ip-data.fqdn
}

output "vms_rdp_access" {
  value = formatlist("RDP_URL=%v:%v", data.azurerm_public_ip.hack-pub-ip-data.fqdn, azurerm_lb_nat_rule.hack-natrule.*.frontend_port)
}

