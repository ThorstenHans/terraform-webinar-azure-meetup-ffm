module "staging" {
  source = "../infrastructure"

  environment_name = "staging"
  location2        = "westeurope"
  asp_size         = "S1"
}
