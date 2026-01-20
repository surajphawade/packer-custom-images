variable "subscription_id" {
  type        = string
  description = "Azure subscription ID where the image will be created."
}

variable "client_id" {
  type        = string
  description = "Azure service principal client (application) ID."
}

variable "client_secret" {
  type        = string
  description = "Azure service principal client secret."
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Active Directory tenant ID."
}

variable "location" {
  type        = string
  description = "Azure region where the image will be built (e.g. eastus)."
  default     = "eastus"
}

variable "image_name" {
  type        = string
  description = "Name of the Azure managed image to be created."
}
