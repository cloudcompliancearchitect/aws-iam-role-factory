output "role_name" {
  description = "The created role name."
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "The created role ARN."
  value       = aws_iam_role.this.arn
}
