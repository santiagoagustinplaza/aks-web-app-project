#Global Variables
variable "location" {
  description = "Location for the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name where the resource is created"
  type        = string
}

variable "environment" {
  description = "The environment name of the resource"
  type        = string
}

variable "project_id" {
  description = "The project ID of the resource"
  type        = string
}

#Azure Container Registry Variables
variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

#Azure Kubernetes Service Variables
variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" { #Optional
  description = "Initial number of nodes in the default pool"
  type        = number
  default     = 1
}

variable "vm_size" { #Optional
  description = "VM size for AKS node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "min_count" { #Optional
  description = "Minimum number of nodes in the default pool for autoscaling"
  type        = number
  default     = 1
}

variable "max_count" { #Optional
  description = "Maximum number of nodes in the default pool for autoscaling"
  type        = number
  default     = 3
}

variable "network_plugin" { #Optional
  description = "Network plugin for AKS (azure, none or kubenet)"
  type        = string
  default     = "azure"
}

variable "network_policy" { #Optional
  description = "Network policy for AKS (calico, cilium or azure)"
  type        = string
  default     = "calico"
}

#Azure Key Vault Variables
variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
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

variable "sql_connection_string_secret_name" { #Optional
  description = "Name of the Key Vault secret to store SQL connection string"
  type        = string
  default     = "sql-connection-string"
}

#Azure SQL Variables
variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable "sql_admin_user" {
  description = "The admin username for SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for SQL Server (sensitive)"
  type        = string
  sensitive   = true
}

variable "sql_sku_name" {
  description = "The SKU for the SQL Database"
  type        = string
  default     = "S0"
}

variable "subnet_id" {
  description = "The subnet ID where the SQL Private Endpoint is created"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the Virtual Network linked to the SQL DNS zone"
  type        = string
}

variable "aks_subnet_start_ip" {
  description = "Start IP address for AKS subnet access"
  type        = string
  default     = "10.0.0.0"
}

variable "aks_subnet_end_ip" {
  description = "End IP address for AKS subnet access"
  type        = string
  default     = "10.0.255.255"
}

#Azure Virtual Network Variables
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" { #Optional
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "subnet_name" { #Optional
  description = "Name of the AKS Subnet"
  type        = string
  default     = "aks-default-subnet"
}

variable "subnet_address_prefixes" { #Optional
  description = "Address prefixes for the AKS Subnet"
  type        = list(string)
  default     = ["10.240.0.0/16"]
}

variable "nsg_name" { #Optional
  description = "Name of the Network Security Group for AKS"
  type        = string
  default     = "aks-nsg"
}