variable "prefix" {
  description = "The prefix used for all resources in this example"
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
  type        = string
  default     = "uksouth"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "The address prefixes to use for the subnets."
  type        = map(string)
  default = {
    jmp  = "10.0.1.0/24"
    dc   = "10.0.2.0/24"
    web  = "10.0.3.0/24"
    app  = "10.0.4.0/24"
    data = "10.0.5.0/24"
  }
}

variable "allowed_source_address_prefix" {
  description = "The Source IP address allow-listed for RDP access to the Jumpbox. Use '*' for all (NOT RECOMMENDED)."
  type        = string
  # No default to force user input for security, but providing a safe fallback example
  # default = "YOUR_IP_ADDRESS" 
}

variable "vm_sizes" {
  description = "Map of VM sizes for different roles"
  type        = map(string)
  default = {
    jumpbox = "Standard_B2s"
    dc      = "Standard_B2s"
    app     = "Standard_B2s"
    web     = "Standard_B2s"
    db      = "Standard_D8_v4"
  }
}

variable "admin_username" {
  description = "Admin username for all VMs"
  type        = string
  default     = "devadmin"
}

variable "admin_password" {
  description = "Admin password for all VMs"
  type        = string
  sensitive   = true # Hides this in CLI output
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "AzureTerraformRefactor"
    ManagedBy   = "Terraform"
  }
}
