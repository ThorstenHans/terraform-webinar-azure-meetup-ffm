module "prod" {
  source = "../infrastructure"

  environment_name = "prod"
  location2        = "westeurope"
  asp_size         = "S2"
  tags = {
    hot = "true"
  }
}
