# Upgrading Notes

This document captures required refactoring on your part when upgrading to a module version that contains breaking changes.

## Upgrading to v1.0.0

### Key Changes

- Introduced support for multiple CIDR blocks in both ingress and egress rules.
- The `cidr_ipv4` and `cidr_ipv6` attributes have been updated from `string` to `list(string)` , allowing multiple CIDR blocks to be specified within `egress_rules` and `ingress_rules`.

#### Variables

The following variables have been modified:

- `egress_rules`:
    - `cidr_ipv4` attribute has changed from `string` to `list(string)`
    - `cidr_ipv6` attribute has changed from `string` to `list(string)`
    
- `ingress_rules`:
    - `cidr_ipv4` attribute has changed from `string` to `list(string)`
    - `cidr_ipv6` attribute has changed from `string` to `list(string)`

Ensure that your configurations are updated accordingly before applying changes. 🚀