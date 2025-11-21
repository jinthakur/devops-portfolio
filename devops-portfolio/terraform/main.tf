# main.tf: Core Infrastructure as Code Example (Azure AKS)

# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# --- Core Resource Group ---
resource "azurerm_resource_group" "rg" {
  name     = "rg-devops-portfolio-aks"
  location = var.location
  tags = {
    Environment = var.environment
    Project     = "DevOps-Portfolio"
  }
}

# --- Virtual Network (VNet) ---
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-aks-portfolio"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# --- Subnet for AKS ---
resource "azurerm_subnet" "aks_subnet" {
  name                 = "subnet-aks"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# --- Azure Kubernetes Service (AKS) Cluster ---
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-portfolio-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-portfolio-dns"

  default_node_pool {
    name                = "default"
    node_count          = var.aks_node_count
    vm_size             = "Standard_DS2_v2"
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

# Note: You would also define variables.tf and outputs.tf 
# to make this configuration reusable and output connection details.
