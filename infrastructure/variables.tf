variable "location2" {
  type        = string
  description = "Azure Location for all our resources"
  // default     = ""
}

variable "environment_name" {
  type    = string
  default = "development"
}

variable "tags" {
  type    = map
  default = {}
}

variable "asp_size" {
  type        = string
  default     = "S1"
  description = "Size of the App Service Plan (S1, S2, ...)"
}
