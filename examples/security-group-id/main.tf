provider "aws" {
  region = "eu-west-1"
}

module "application_security_group" {
  source = "../.."

  description = "MyApplication security group"
  name_prefix = "my-application-"

  ingress_rules = {
    private_access = {
      cidr_ipv4   = ["10.73.0.0/20"]
      description = "Allow access from private network range"
    }
  }
}

module "database_security_group" {
  source = "../.."

  description = "Security group for the database layer"
  name_prefix = "database-"

  ingress_rules = {
    allow_security_group = {
      referenced_security_group_id = module.application_security_group.id
      description                  = "Allow access from the application security group"
    }
  }
}
