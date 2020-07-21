provider "azurerm" {
  version = "~>2.0"
  features {}
}

locals {
  unique_name_stub = substr(module.naming.unique-seed, 0, 5)
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
}

resource "azurerm_resource_group" "test_group" {
  name     = "${module.naming.resource_group.slug}-${module.naming.log_analytics_workspace.slug}-max-test-${local.unique_name_stub}"
  location = "uksouth"
}

module "terraform-azurerm-log-analytics" {
  source                                = "../../"
  resource_group_name                   = azurerm_resource_group.test_group.name
  resource_group_location               = azurerm_resource_group.test_group.location
  prefix                                = [local.unique_name_stub]
  suffix                                = [local.unique_name_stub]
  log_analytics_workspace_sku           = "PerGB2018"
  log_analytics_retention_in_days       = 730
  alternate_automation_account_location = "westeurope"
  automation_account_sku                = "Basic"
}
