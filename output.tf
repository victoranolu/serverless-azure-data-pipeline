output "resource_group_id" {
  value = [azurerm_resource_group.terraform-rg.id, azurerm_resource_group.terraform-rg.name]
}