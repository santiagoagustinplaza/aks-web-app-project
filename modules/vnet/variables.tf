variable "vnet_name" { #Optional
  description = "Name of the Virtual Network"
  type        = string
  default     = "aks-default-vnet"
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
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