#Required Variables
variable "resource_group_name" {
  type        = string
  description = "The Resource Group in which to put the Log Analytics resources"
}

#Optional Variables
variable "prefix" {
  type        = list(string)
  description = "A naming prefix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "suffix" {
  type        = list(string)
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "log_analytics_workspace_sku" {
  type        = string
  description = "The Azure Log Analytics Workspace SKU to create."
  default     = "PerGB2018"
}

variable "log_analytics_retention_in_days" {
  type        = number
  description = "The number of days to retain Azure Log Analytics Workspace information."
  default     = 730
}

variable "alternate_automation_account_location" {
  type        = string
  description = "An alternate Azure region to deploy the Azure Automation Account to in the event it is not available in the same Azure Region as the Resource Group."
  default     = ""
}

variable "automation_account_sku" {
  type        = string
  description = "The Azure Automation SKU to create."
  default     = "Basic"
}



