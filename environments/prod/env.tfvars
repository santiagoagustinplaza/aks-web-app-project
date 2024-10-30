# General Variables
resource_group_name = "myResourceGroup"
location            = "East US"
project_id          = "2468"
environment         = "production"

# Azure Container Registry Module
acr_name = "myContainerRegistry"

# AKS Module
aks_name   = "myAKSCluster"
dns_prefix = "myaksdns"

# Key Vault Module
key_vault_name = "myKeyVault"

# SQL Module
sql_server_name    = "mySqlServer"
sql_database_name  = "myDatabase"
sql_admin_user     = "adminuser"
sql_admin_password = "mySecurePassword" # Ensure this is secure!

# Virtual Network Module
vnet_name = "myVNet"