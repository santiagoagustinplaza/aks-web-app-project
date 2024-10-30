variable "environment" {
  description = "The environment name of the resource"
  type        = string
}

variable "project_id" {
  description = "The project ID of the resource"
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "Location for ACR resource"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name where the ACR is created"
  type        = string
}

variable "aks_principal_id" {
  description = "The principal ID of the AKS managed identity used to assign permissions to the ACR"
  type        = string
}