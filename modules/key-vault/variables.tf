variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Location of the Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "key_vault_sku" { #Optional
  description = "SKU tier of the Key Vault"
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" { #Optional
  description = "Enable Purge Protection for the Key Vault"
  type        = bool
  default     = true
}

variable "aks_managed_identity_id" {
  description = "Object ID of the AKS Managed Identity with access to Key Vault secrets"
  type        = string
}

variable "sql_connection_string" {
  description = "Connection string for Azure SQL Database used by AKS app"
  type        = string
  sensitive   = true
}

variable "sql_connection_string_secret_name" { #Optional
  description = "Name of the Key Vault secret to store SQL connection string"
  type        = string
  default     = "sql-connection-string"
}