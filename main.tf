resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  acr_name            = var.acr_name
  aks_principal_id    = module.aks.aks_managed_identity_principal_id
  project_id          = var.project_id
  environment         = var.environment
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  aks_name            = var.aks_name
  dns_prefix          = var.dns_prefix
  project_id          = var.project_id
  environment         = var.environment
}

module "kv" {
  source                  = "./modules/kv"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = var.location
  key_vault_name          = var.key_vault_name
  aks_managed_identity_id = module.aks.aks_managed_identity_principal_id
  sql_connection_string   = module.sql.sql_connection_string
  project_id              = var.project_id
  environment             = var.environment
}

module "sql" {
  source              = "./modules/sql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sql_server_name     = var.sql_server_name
  sql_database_name   = var.sql_database_name
  virtual_network_id  = module.vnet.vnet_id
  subnet_id           = module.vnet.subnet_id
  sql_admin_user      = var.sql_admin_user
  sql_admin_password  = var.sql_admin_password
  project_id          = var.project_id
  environment         = var.environment
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = var.vnet_name
  project_id          = var.project_id
  environment         = var.environment
}