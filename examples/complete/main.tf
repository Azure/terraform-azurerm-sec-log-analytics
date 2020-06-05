provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "random_string" "resource_group_name_prefix" {
  length    = 5
  special   = false
  lower     = true
  min_lower = 5
}

resource "azurerm_resource_group" "test_group" {
  name     = "rg-log-analytics-minimal-test-${random_string.resource_group_name_prefix.result}"
  location = "uksouth"
}

module "terraform-azurerm-log-analytics" {
  source                                = "../"
  resource_group_name                   = azurerm_resource_group.test_group.name
  name_prefix                           = random_string.resource_group_name_prefix.result
  name_suffix                           = random_string.resource_group_name_prefix.result
  log_analytics_workspace_sku           = "PerGB2018"
  log_analytics_retention_in_days       = 730
  alternate_automation_account_location = "westeurope"
  automation_account_sku                = "Basic"
}
