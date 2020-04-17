locals {
  default_tags = {
    app         = "Azure Virtual Meetup"
    responsible = "Thorsten Hans"
  }

  all_tags = merge(local.default_tags, var.tags)
}

resource "azurerm_resource_group" "webinar" {
  name     = "rg_webinar_${var.environment_name}"
  location = var.location2
  tags     = local.all_tags
}

resource "azurerm_application_insights" "insights" {
  name                = "ai_webinar_${var.environment_name}"
  resource_group_name = azurerm_resource_group.webinar.name
  location            = azurerm_resource_group.webinar.location
  application_type    = "web"
  tags                = local.all_tags
}

resource "azurerm_app_service_plan" "webappplan" {
  name                = "asp_webinar_${var.environment_name}"
  resource_group_name = azurerm_resource_group.webinar.name
  location            = azurerm_resource_group.webinar.location
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = var.asp_size
  }
  tags = local.all_tags
}

resource "azurerm_app_service" "webapp" {
  name = "as-webinar-2348129371293-${var.environment_name}"
  // https://as_webinar_development-{someid}.azurewebsites.net

  resource_group_name = azurerm_resource_group.webinar.name
  location            = azurerm_resource_group.webinar.location
  app_service_plan_id = azurerm_app_service_plan.webappplan.id
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.insights.instrumentation_key
  }
  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|nginx:latest"
  }
  tags = local.all_tags
}
