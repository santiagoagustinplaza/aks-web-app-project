# Data resource to get current client configuration
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Define the AKS Cluster with Azure AD and Managed Identity
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  # Enable Azure RBAC and Azure AD integration for user authentication
  azure_active_directory_role_based_access_control {
    tenant_id              = data.azurerm_client_config.current.tenant_id
    admin_group_object_ids = [azurerm_ad_group.admin_group.object_id]
  }

  # Default Node Pool Configuration
  default_node_pool {
    name                 = "default"
    node_count           = var.node_count
    vm_size              = var.vm_size
    auto_scaling_enabled = true
    min_count            = var.min_count
    max_count            = var.max_count
  }

  # Managed Identity
  identity {
    type = "SystemAssigned"
  }

  # Networking Configuration
  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
  }
}

# Define AD Groups
resource "azuread_group" "admin_group" {
  display_name     = "AKS Admin Group"
  mail_enabled     = false
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

# Role Assignment for AKS Admin Group
resource "azurerm_role_assignment" "admin_role_assignment" {
  principal_id         = azurerm_ad_group.admin_group.object_id
  role_definition_name = "Azure Kubernetes Service Admin"
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
}