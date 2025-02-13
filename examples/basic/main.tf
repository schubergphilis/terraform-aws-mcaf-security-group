provider "aws" {
  region = "eu-west-1"
}

module "basic" {
  source = "../.."

  description = "MyApplication security group"
  name_prefix = "my-application-"

  rules = {
    private_access = {
      cidr_ipv4   = "10.64.0.0/12"
      description = "Allow access from this range"
      type        = "ingress"
    }
  }
}
