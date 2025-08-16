output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_virtual_machine.vm.id
}

output "vm_private_ip" {
  description = "Private IP of the Virtual Machine"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "vm_location" {
  description = "Azure region where VM is deployed"
  value       = azurerm_virtual_machine.vm.location
}
