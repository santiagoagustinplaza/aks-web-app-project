output "sql_server_name" {
  description = "The name of the SQL Server"
  value       = azurerm_sql_server.sql_server.name
}

output "sql_database_name" {
  description = "The name of the SQL Database"
  value       = azurerm_sql_database.sql_db.name
}

output "sql_private_endpoint_ip" {
  description = "The private IP address of the SQL Private Endpoint"
  value       = azurerm_private_endpoint.sql_private_endpoint.private_ip_address
}

output "sql_connection_string" {
  value     = "Server=tcp:${azurerm_sql_server.sql_server.name}.database.windows.net,1433;Initial Catalog=${azurerm_sql_database.sql_db.name};Persist Security Info=False;User ID=${var.sql_admin_user};Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive = true
}