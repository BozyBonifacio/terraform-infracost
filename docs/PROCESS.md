# Terraform Process Guide

This document explains the Terraform process demonstrated by this repository.

## 1. Format

`terraform fmt` enforces consistent Terraform style.

```bash
terraform fmt -recursive
```

## 2. Initialize

`terraform init` downloads providers and prepares the working directory.

```bash
terraform init
```

## 3. Validate

`terraform validate` checks whether the Terraform configuration is syntactically valid.

```bash
terraform validate
```

## 4. Plan

`terraform plan` previews changes before they are applied.

```bash
terraform plan -var-file="terraform.tfvars"
```

## 5. Cost estimate

[Infracost](https://www.infracost.io/) estimates the cost impact of a change
before it is applied, so reviewers can see the price tag alongside the plan.

```bash
# One-time setup (free API key)
infracost auth login

# Estimate all environments defined in infracost.yml
infracost breakdown --config-file=infracost.yml
```

In CI, Infracost diffs the pull request against the base branch and posts the
cost difference as a PR comment.

> Note: each environment declares a small example AWS workload (EC2 + EBS + RDS)
> purely so Infracost has something to price. It is configured with mock
> credentials and `skip_*` flags, so `terraform plan` and Infracost run fully
> offline — nothing is ever deployed and no AWS account is required. Dev and
> prod are sized differently, so the cost estimate differs between them.

## 6. Apply

`terraform apply` should normally be gated by review, approval, or a protected branch workflow.

```bash
terraform apply -var-file="terraform.tfvars"
```

## Recommended DevOps workflow

1. Developer opens a pull request.
2. CI runs format, init, validate, and plan.
3. Infracost posts the estimated cost difference on the pull request.
4. Reviewer checks the Terraform plan output and the cost impact.
5. Approved changes are merged.
6. Apply is triggered manually or by a controlled release process.

## Environment strategy

This repo uses separate directories for each environment:

- `environments/dev`
- `environments/prod`

Each environment calls the same reusable module but passes different values.

## Secret management guidance

Do not commit secrets to Terraform code or tfvars files.

For real cloud projects, use one of these options:

- GitHub Actions secrets
- Cloud provider secret managers
- Terraform Cloud or OpenTofu/Terraform backend variables
- Vault or other enterprise secret management tools
