resource "aws_security_group" "default" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource" - False positive.

  description            = var.description
  name                   = var.name
  name_prefix            = var.name_prefix
  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags                   = var.tags
  vpc_id                 = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
  }
}

resource "aws_vpc_security_group_ingress_rule" "default" {
  for_each = { for key, rule in var.rules : key => rule if rule.type == "ingress" }

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

resource "aws_vpc_security_group_egress_rule" "default" {
  for_each = { for key, rule in var.rules : key => rule if rule.type == "egress" }

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
