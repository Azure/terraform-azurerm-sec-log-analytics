provider "azurerm" {
  version = "~>2.0"
  features {}
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
  prefix = var.prefix
  suffix = var.suffix
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = module.naming.log_analytics_workspace.name_unique
  location            = data.azurerm_resource_group.base.location
  resource_group_name = data.azurerm_resource_group.base.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_retention_in_days
}

resource "azurerm_automation_account" "automation_account" {
  name                = module.naming.automation_account.name_unique
  location            = var.alternate_automation_account_location != "" ? var.alternate_automation_account_location : data.azurerm_resource_group.base.location
  resource_group_name = data.azurerm_resource_group.base.name
  sku_name            = var.automation_account_sku
}

resource "azurerm_log_analytics_linked_service" "linked_service" {
  resource_group_name = data.azurerm_resource_group.base.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics.name
  resource_id         = azurerm_automation_account.automation_account.id
}


