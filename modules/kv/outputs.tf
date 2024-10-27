output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.main_kv.id
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main_kv.vault_uri
}

output "sql_connection_string_secret_id" {
  description = "ID of the SQL connection string secret in Key Vault"
  value       = azurerm_key_vault_secret.sql_connection_string.id
}