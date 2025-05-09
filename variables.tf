variable "description" {
  type        = string
  default     = null
  description = "Description of the security group."
}

variable "egress_rules" {
  type = map(object({
    cidr_ipv4                    = optional(list(string))
    cidr_ipv6                    = optional(list(string))
    description                  = string
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "-1")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number)
  }))
  default     = {}
  description = "Security group egress rules."

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) : (
        rule.cidr_ipv4 != null ||
        rule.cidr_ipv6 != null ||
        rule.prefix_list_id != null ||
        rule.referenced_security_group_id != null
      )
    ])
    error_message = "Each rule must provide at least one of: 'cidr_ipv4', 'cidr_ipv6', 'prefix_list_id', or 'referenced_security_group_id'."
  }
}

variable "ingress_rules" {
  type = map(object({
    cidr_ipv4                    = optional(list(string))
    cidr_ipv6                    = optional(list(string))
    description                  = string
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "-1")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    to_port                      = optional(number)
  }))
  default     = {}
  description = "Security group ingress rules."

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) : (
        rule.cidr_ipv4 != null ||
        rule.cidr_ipv6 != null ||
        rule.prefix_list_id != null ||
        rule.referenced_security_group_id != null
      )
    ])
    error_message = "Each rule must provide at least one of: 'cidr_ipv4', 'cidr_ipv6', 'prefix_list_id', or 'referenced_security_group_id'."
  }
}

variable "name_prefix" {
  type        = string
  description = "Name prefix of the security group."
}

variable "revoke_rules_on_delete" {
  type        = bool
  default     = false
  description = "Instruct Terraform to revoke all of the security group attached ingress and egress rules before deleting the group itself."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign on all resources."
}

variable "timeouts" {
  type = object({
    create = optional(string, "10m")
    delete = optional(string, "15m")
  })
  default     = {}
  description = "Define custom maximum timeout for creating and deleting the security group."
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The ID of the VPC in which the security group will be created."
}
