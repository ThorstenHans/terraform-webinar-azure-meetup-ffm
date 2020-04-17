module "dev" {
  source = "../infrastructure"

  environment_name = "dev"
  location2        = "westeurope"
  asp_size         = "S1"
}
