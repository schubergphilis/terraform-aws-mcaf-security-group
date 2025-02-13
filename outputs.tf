output "arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = aws_security_group.default.arn
}

output "id" {
  description = "ID of the security group"
  value       = aws_security_group.default.id
}
