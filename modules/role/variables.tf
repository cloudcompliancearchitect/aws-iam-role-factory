variable "name" {
  description = "IAM role name."
  type        = string
}

variable "principal_arns" {
  description = "List of allowed AWS principal ARNs (users or roles) that can assume this role."
  type        = list(string)
}

variable "require_mfa" {
  description = "If true, enforce aws:MultiFactorAuthPresent on assume."
  type        = bool
  default     = true
}

variable "permissions_boundary_arn" {
  description = "Optional permissions boundary ARN."
  type        = string
  default     = null
}

variable "tags" {
  description = "Optional tags to apply to the role."
  type        = map(string)
  default     = {}
}
