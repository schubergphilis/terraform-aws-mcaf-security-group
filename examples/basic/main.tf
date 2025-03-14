provider "aws" {
  region = "eu-west-1"
}

module "basic" {
  source = "../.."

  description = "MyApplication security group"
  name_prefix = "my-application-"

  ingress_rules = {
    private_access = {
      cidr_ipv4   = ["10.64.0.0/20", "10.67.0.0/20"]
      description = "Allow access from this range"
    }
  }
}
