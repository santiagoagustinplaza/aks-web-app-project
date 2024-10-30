resource "azurerm_sql_server" "sql_server" {
  depends_on                   = [module.sql-server-metadata-validation]
  name                         = module.sql-server-metadata-validation.constructed_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
  tags                         = module.sql-server-metadata-validation.tags
}

resource "azurerm_sql_database" "sql_db" {
  depends_on          = [module.sql-db-metadata-validation, azurerm_sql_server.sql_server]
  name                = var.sql_database_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = var.sql_sku_name
  tags                = module.sql-db-metadata-validation.tags
}

# Private Endpoint for secure access within VNet
resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "${var.sql_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "sqlPrivateLink"
    private_connection_resource_id = azurerm_sql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}

# Private DNS Zone for SQL Database
resource "azurerm_private_dns_zone" "sql_dns_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

# Link DNS zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "${var.sql_server_name}-dnslink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns_zone.name
  virtual_network_id    = var.virtual_network_id
}

# Add an A record for the SQL private endpoint
resource "azurerm_private_dns_a_record" "sql_a_record" {
  name                = azurerm_sql_server.sql_server.name
  zone_name           = azurerm_private_dns_zone.sql_dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.sql_private_endpoint.private_ip_address]
}

# SQL Server Firewall Rules to restrict access
resource "azurerm_sql_firewall_rule" "aks_subnet_rule" {
  name                = "AllowAksSubnet"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.sql_server.name
  start_ip_address    = var.aks_subnet_start_ip
  end_ip_address      = var.aks_subnet_end_ip
}

module "sql-server-metadata-validation" {
  source              = "../../sub-modules/metadata-validation"
  provided_name       = var.sql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name
  project_id          = var.project_id
  environment         = var.environment
}

module "sql-db-metadata-validation" {
  source              = "../../sub-modules/metadata-validation"
  provided_name       = var.sql_database_name
  location            = var.location
  resource_group_name = var.resource_group_name
  project_id          = var.project_id
  environment         = var.environment
}