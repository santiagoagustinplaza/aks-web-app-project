variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group for AKS"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "azure_ad_admin_group_object_id" {
  description = "Azure AD Group Object ID for AKS Admins"
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