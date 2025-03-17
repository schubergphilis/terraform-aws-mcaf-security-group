# terraform-aws-mcaf-security-group

Terraform module to manage an AWS Security Group.

> [!NOTE]  
> This module only supports `name_prefix` as input and not `name`. Changing a security group’s `name` in Terraform forces its replacement, which can cause deployment failures due to dependencies with other AWS resources. Since AWS does not allow deleting a security group that is still associated with another resource. Using `name_prefix` avoids unnecessary recreation, and `create_before_destroy` ensures smooth updates without disruption.

## Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix of the security group. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of the security group. | `string` | `null` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | Security group egress rules. | <pre>map(object({<br/>    cidr_ipv4                    = optional(list(string))<br/>    cidr_ipv6                    = optional(list(string))<br/>    description                  = string<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "-1")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Security group ingress rules. | <pre>map(object({<br/>    cidr_ipv4                    = optional(list(string))<br/>    cidr_ipv6                    = optional(list(string))<br/>    description                  = string<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "-1")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | Instruct Terraform to revoke all of the security group attached ingress and egress rules before deleting the group itself. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign on all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define custom maximum timeout for creating and deleting the security group. | <pre>object({<br/>    create = optional(string, "10m")<br/>    delete = optional(string, "15m")<br/>  })</pre> | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which the security group will be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_id"></a> [id](#output\_id) | ID of the security group |
| <a name="output_name"></a> [name](#output\_name) | Name of the security group |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | Owner ID of the security group |
<!-- END_TF_DOCS -->

## License

**Copyright:** Schuberg Philis

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
