module "role" {
  source = "../../modules/role"

  name                    = var.role_name
  principal_arns          = var.principal_arns
  permissions_boundary_arn = var.permissions_boundary_arn
  require_mfa             = var.require_mfa
  tags = {
    "project" = "iam-role-factory"
    "module"  = "auditor"
  }
}

# Attach AWS managed SecurityAudit policy to the role.
resource "aws_iam_role_policy_attachment" "security_audit" {
  role       = module.role.role_name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

output "role_name" {
  value = module.role.role_name
}

output "role_arn" {
  value = module.role.role_arn
}
