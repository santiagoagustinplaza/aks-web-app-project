output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.main_kv.id
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main_kv.vault_uri
}