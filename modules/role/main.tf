locals {
  mfa_condition = var.require_mfa ? {
    Bool = {
      "aws:MultiFactorAuthPresent" = "true"
    }
  } : null
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "AllowExplicitPrincipals"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.principal_arns
    }

    dynamic "condition" {
      for_each = local.mfa_condition == null ? [] : [1]
      content {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.name
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  permissions_boundary = var.permissions_boundary_arn
  tags                 = var.tags
}
