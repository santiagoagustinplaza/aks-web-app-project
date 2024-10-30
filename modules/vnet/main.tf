# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  depends_on          = [module.metadata-validation]
  name                = module.metadata-validation.constructed_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = module.metadata-validation.tags
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.subnet_address_prefixes
}

# Create Network Security Group
resource "azurerm_network_security_group" "aks_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# NSG Inbound Rule to Allow HTTP (Port 80) and HTTPS (Port 443) from Internet
resource "azurerm_network_security_rule" "aks_inbound_http_https" {
  name                        = "allow_http_https"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

# NSG Inbound Rule to Allow AKS Node Communication (e.g., Node Port Range)
resource "azurerm_network_security_rule" "aks_inbound_node_ports" {
  name                        = "allow_aks_node_ports"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["30000-32767"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

# NSG Outbound Rule to Allow Internet Access
resource "azurerm_network_security_rule" "aks_outbound_internet" {
  name                        = "allow_outbound_internet"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

# Attach NSG to AKS Subnet
resource "azurerm_subnet_network_security_group_association" "aks_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.aks-default.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

module "metadata-validation" {
  source              = "../../sub-modules/metadata-validation"
  provided_name       = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  project_id          = var.project_id
  environment         = var.environment
}