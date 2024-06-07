data "azurerm_client_config" "current" {}


data "azurerm_resource_group" "main" {
  name     = var.resource_group_name
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_user_assigned_identity" "main" {
  name                = var.managed_identity_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
}

resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  principal_id         = azurerm_user_assigned_identity.main.principal_id
  role_definition_name = "Contributor"
  scope                = "subscriptions/${data.azurerm_client_config.current.subscription_id}"
}