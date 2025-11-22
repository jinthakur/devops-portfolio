# variables.tf: Input variables for the infrastructure module

# --- General Configuration Variables ---

variable "project_name" {
  description = "A unique prefix for all resources created."
  type        = string
  default     = "portfolio-demo"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}

# --- Azure Kubernetes Service (AKS) Variables ---

variable "aks_node_count" {
  description = "The number of worker nodes for the default AKS node pool."
  type        = number
  default     = 3
}

variable "aks_vm_size" {
  description = "The size of the virtual machines in the AKS node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

# --- Network Configuration Variables ---

variable "vnet_address_space" {
  description = "The CIDR block for the main Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "The CIDR block for the AKS subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
