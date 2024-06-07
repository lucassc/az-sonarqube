variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
}

variable "container_name" {
  description = "Name of the Azure Storage Container"
}

variable "managed_identity_name" {
  description = "Name of the Managed Identity"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default = "rg-terraform-backend"
}