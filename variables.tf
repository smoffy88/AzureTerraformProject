variable "prefix" {
  description = "The prefix used for all resources in this example"
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
  type        = string
  default = "uksouth"
}

variable "admin_username" {
  description = "Admin username for all VMs"
  type        = string
  default    = "devadmin"
}

variable "admin_password" {
  description = "Admin password for all VMs"
  type        = string
  sensitive   = true # Hides this in CLI output
  repository  = "AzureTerraformProject" # GitHub repository name
  secret_name = "VM_ADMIN_PASSWORD"          # GitHub Secret name
}