# Import the Azure Client Configuration for Tenant ID
data "azurerm_client_config" "current" {}

# Create Azure Key Vault
resource "azurerm_key_vault" "main_kv" {
  name                     = var.key_vault_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku_name                 = var.key_vault_sku
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = var.purge_protection_enabled

  # Access policy to allow AKS Managed Identity to read secrets
  access_policy {
    tenant_id          = data.azurerm_client_config.current.tenant_id
    object_id          = var.aks_managed_identity_id
    secret_permissions = ["Get", "List"]
  }
}

# Create Key Vault Secret to Store SQL Connection String
resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = var.sql_connection_string_secret_name
  value        = var.sql_connection_string
  key_vault_id = azurerm_key_vault.main_kv.id
}