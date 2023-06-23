variable "cidrs" {
  type = map(string)

  default = {
    "private_subnet"  = "172.31.0.0/28"
    "private_subnet2" = "172.31.0.16/28"
    "public_subnet"   = "172.31.0.128/25"
    "vpc"             = "172.31.0.0/16"
  }
}

variable "db_username" {
  default = "franco"
}

variable "db_password" {
  default = "rockolify"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

variable "spotify_client_id" {}
variable "spotify_secret" {}
variable "sentry_dsn" {}