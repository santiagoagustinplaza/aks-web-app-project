resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  # Disable admin access for security best practices
  admin_enabled = false
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = var.aks_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}