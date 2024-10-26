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

variable "key_vault_sku" {
  description = "SKU tier of the Key Vault"
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Enable Purge Protection for the Key Vault"
  type        = bool
  default     = true
}

variable "soft_delete_enabled" {
  description = "Enable Soft Delete for the Key Vault"
  type        = bool
  default     = true
}

variable "aks_managed_identity_id" {
  description = "Object ID of the AKS Managed Identity with access to Key Vault secrets"
  type        = string
}