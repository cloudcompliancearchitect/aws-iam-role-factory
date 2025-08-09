# AWS IAM Role Factory (mini)

Minimal, pragmatic Terraform module to spin up IAM roles with:
- **Explicit allowed principals** (`principal_arns`)
- Optional **MFA requirement** on assume (`require_mfa`, default: `true`)
- Optional **permissions boundary**

## Quick start

```bash
cd examples/auditor
terraform init
terraform apply -var 'role_name=auditor' -var 'principal_arns=["arn:aws:iam::111122223333:user/alice"]' -var 'permissions_boundary_arn='
```

> Replace the `principal_arns` with the IAM user/role ARN(s) that should be allowed to assume.

## Module Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | string | n/a | Role name. |
| `principal_arns` | list(string) | n/a | Allowed AWS principal ARNs that may `sts:AssumeRole`. |
| `require_mfa` | bool | `true` | If `true`, enforces `aws:MultiFactorAuthPresent = true` on assume. |
| `permissions_boundary_arn` | string | `null` | Optional permissions boundary to attach to the role. |
| `tags` | map(string) | `{}` | Optional tags. |

## Outputs

| Name | Description |
|------|-------------|
| `role_name` | The created role's name. |
| `role_arn` | The created role's ARN. |

## Validate (manual)

1) **Try assuming without MFA** (should fail when `require_mfa = true`):
```bash
aws sts assume-role       --role-arn $(terraform output -raw role_arn)       --role-session-name test-no-mfa       --profile <profile_without_mfa>
```

2) **Assume with MFA** (should succeed):
```bash
SERIAL=$(aws iam list-mfa-devices --user-name <your_user> --query 'MFADevices[0].SerialNumber' --output text --profile <profile_with_mfa>)
aws sts assume-role       --role-arn $(terraform output -raw role_arn)       --role-session-name test-with-mfa       --serial-number $SERIAL       --token-code <6-digit-code>       --profile <profile_with_mfa>
```

3) **Use wrong principal** (not in `principal_arns`) — try with a different profile (should fail).

## Example: Auditor Role

See `examples/auditor`. It creates a role with AWS managed **SecurityAudit** policy, restricted to `principal_arns` and MFA.

## License

MIT
```
