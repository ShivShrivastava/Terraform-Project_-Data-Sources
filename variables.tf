variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "shiv"
}

variable "computer_name" {
  description = "The computer name for the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
