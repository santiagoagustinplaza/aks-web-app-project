output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.aksvnet.id
}

output "subnet_id" {
  description = "ID of the AKS Subnet"
  value       = azurerm_subnet.aks-default.id
}

output "nsg_id" {
  description = "ID of the Network Security Group"
  value       = azurerm_network_security_group.aks_nsg.id
}