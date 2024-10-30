resource "azurerm_container_registry" "acr" {
  depends_on          = [module.metadata-validation]
  name                = module.metadata-validation.constructed_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  tags                = module.metadata-validation.tags

  # Disable admin access for security best practices
  admin_enabled = false
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  depends_on           = [azurerm_container_registry.acr]
  principal_id         = var.aks_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

module "metadata-validation" {
  source              = "../../sub-modules/metadata-validation"
  provided_name       = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  project_id          = var.project_id
  environment         = var.environment
}