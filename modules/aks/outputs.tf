output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_managed_identity_principal_id" {
  description = "The Principal ID of the AKS managed identity"
  value       = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}