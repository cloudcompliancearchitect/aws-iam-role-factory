variable "role_name" {
  type        = string
  description = "Name for the auditor role."
  default     = "auditor"
}

variable "principal_arns" {
  type        = list(string)
  description = "Allowed principals that can assume the role."
}

variable "permissions_boundary_arn" {
  type        = string
  description = "Optional permissions boundary ARN for the role."
  default     = null
}

variable "require_mfa" {
  type        = bool
  description = "Require MFA to assume the role."
  default     = true
}
