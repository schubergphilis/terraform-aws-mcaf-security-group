# We use an intermediate list because a single rule with multiple CIDRs needs to expand into several objects.
# Each expanded object gets a unique key by combining the original rule key with each individual CIDR.
# Direct map creation wouldn't allow one input rule to generate multiple entries.
# The list makes sure every object has the same structure with explicit cidr_ipv4 and cidr_ipv6 keys.
#
# Additionally, Terraform requires both outcomes of a conditional (?:) to return the same structure.
# When a rule has CIDRs (cidr_ipv4 or cidr_ipv6), we use a for expression to create multiple objects,
# each with a unique key ( "${key}-${cidr}") and explicit CIDR fields.
# If a rule has no CIDRs, we still return an object with the same keys, but with null values.
# This consistent schema meets Terraform's type requirements.

locals {
  egress_rules = { for rule in flatten([
    for key, rule in var.egress_rules : (
      rule.cidr_ipv4 != null || rule.cidr_ipv6 != null
      ? [
        for cidr in concat(
          rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [],
          rule.cidr_ipv6 != null ? rule.cidr_ipv6 : []
          ) : merge(rule, {
            key       = "${key}-${cidr}"
            cidr_ipv4 = contains(rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [], cidr) ? cidr : null
            cidr_ipv6 = contains(rule.cidr_ipv6 != null ? rule.cidr_ipv6 : [], cidr) ? cidr : null
        })
      ]
      : [
        merge(rule, {
          key       = key
          cidr_ipv4 = null
          cidr_ipv6 = null
        })
      ]
    )
  ]) : rule.key => rule }
  ingress_rules = { for rule in flatten([
    for key, rule in var.ingress_rules : (
      rule.cidr_ipv4 != null || rule.cidr_ipv6 != null
      ? [
        for cidr in concat(
          rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [],
          rule.cidr_ipv6 != null ? rule.cidr_ipv6 : []
          ) : merge(rule, {
            key       = "${key}-${cidr}"
            cidr_ipv4 = contains(rule.cidr_ipv4 != null ? rule.cidr_ipv4 : [], cidr) ? cidr : null
            cidr_ipv6 = contains(rule.cidr_ipv6 != null ? rule.cidr_ipv6 : [], cidr) ? cidr : null
        })
      ]
      : [
        merge(rule, {
          key       = key
          cidr_ipv4 = null
          cidr_ipv6 = null
        })
      ]
    )
  ]) : rule.key => rule }
}

resource "aws_security_group" "default" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource" - False positive.

  description            = var.description
  name_prefix            = var.name_prefix
  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags                   = merge(var.tags, { "NamePrefix" = var.name_prefix })
  vpc_id                 = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
  }
}

resource "aws_vpc_security_group_egress_rule" "default" {
  for_each = local.egress_rules

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.default.id
  tags                         = var.tags
  to_port                      = each.value.to_port
}

resource "aws_vpc_security_group_ingress_rule" "default" {
  for_each = local.ingress_rules

  cidr_ipv4                    = each.value.cidr_ipv4
  cidr_ipv6                    = each.value.cidr_ipv6
  description                  = each.value.description
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = each.value.prefix_list_id
  referenced_security_group_id = each.value.referenced_security_group_id
  security_group_id            = aws_security_group.default.id
  tags                         = var.tags
  to_port                      = each.value.to_port
}
