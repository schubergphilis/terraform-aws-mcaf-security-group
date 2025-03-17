# terraform-aws-mcaf-security-group

Terraform module to manage an AWS Security Group.

> [!NOTE]  
> This module only supports `name_prefix` as input and not `name`. Changing a security group’s `name` in Terraform forces its replacement, which can cause deployment failures due to dependencies with other AWS resources. Since AWS does not allow deleting a security group that is still associated with another resource. Using `name_prefix` avoids unnecessary recreation, and `create_before_destroy` ensures smooth updates without disruption.

## Usage

<!-- BEGIN_TF_DOCS -->

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
