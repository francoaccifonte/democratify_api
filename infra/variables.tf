variable "cidrs" {
  type = map(string)

  default = {
    "private_subnet" = "172.31.0.0/19"
    "public_subnet" = "172.31.128.0/17"
    "vpc" = "172.31.0.0/16"
  }
}