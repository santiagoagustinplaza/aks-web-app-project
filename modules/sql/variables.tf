variable "environment" {
  description = "The environment name of the resource"
  type        = string
}

variable "project_id" {
  description = "The project ID of the resource"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where SQL resources are created"
  type        = string
}

variable "location" {
  description = "The location for SQL resources"
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