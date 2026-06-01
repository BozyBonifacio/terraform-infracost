# Terraform Process Showcase

A safe, GitHub-ready Terraform demo project that showcases a professional DevOps workflow without creating cloud resources or requiring Azure/AWS/GCP credentials.

This project is intended for a portfolio or public profile. It demonstrates how you structure Terraform code, validate changes, review plans, and separate environments.

## What this demonstrates

- Terraform project structure
- Reusable module design
- Environment separation for `dev` and `prod`
- Variable validation and outputs
- `terraform fmt`, `init`, `validate`, and `plan`
- Infracost cost estimates on pull requests
- GitHub Actions CI for pull requests
- Manual approval-style apply workflow
- Safe providers: `random`/`local` plus a mock-credential AWS workload that is priced but never deployed

## Repository structure

```text
.
├── .github/workflows/
│   ├── terraform-ci.yml
│   └── terraform-apply.yml
├── environments/
│   ├── dev/
│   └── prod/
├── modules/
│   ├── profile-site-metadata/
│   └── example-workload/
├── docs/
│   └── PROCESS.md
├── scripts/
│   └── validate-local.sh
├── infracost.yml
├── .gitignore
└── README.md
```

## Quick start

Install Terraform, then run:

```bash
cd environments/dev
terraform init
terraform fmt -check -recursive ../..
terraform validate
terraform plan
```

To run both environments locally:

```bash
bash scripts/validate-local.sh
```

## Cost estimates with Infracost

[Infracost](https://www.infracost.io/) shows the cost impact of a change before
it ships. CI runs it on every pull request and posts the cost difference as a
comment.

To run it locally:

```bash
# Install: https://www.infracost.io/docs/#1-install-infracost
infracost auth login                          # one-time, free API key
infracost breakdown --config-file=infracost.yml
```

For CI, add your key as a repository secret named `INFRACOST_API_KEY`
(Settings → Secrets and variables → Actions).

The estimate covers the example AWS workload described below, so the PR comment
shows a real monthly cost and a difference between `dev` and `prod`.

### Free tier only

The CI job sets `INFRACOST_ENABLE_CLOUD=false`, so runs are **not** uploaded to
Infracost Cloud. Cost estimates and PR comments use the free Cloud Pricing API
and stay within the free plan. Governance features (tag policies, FinOps
policies, cost guardrails) are part of paid Infracost Cloud and are
intentionally not relied on here — so CI never fails on a policy check.

## How to showcase this on GitHub

1. Create a new repository named `terraform-process-showcase`.
2. Push this project to GitHub.
3. Open a pull request that changes a variable in `environments/dev/terraform.tfvars`.
4. Show the GitHub Actions workflow running `fmt`, `validate`, and `plan`, plus the Infracost comment with the cost difference.
5. The manual apply workflow is demo-only. Because the AWS provider uses mock credentials, `apply` cannot create the example cloud resources — so nothing is provisioned and no cloud bill is incurred.

## Example workload for cost estimates

To make Infracost produce a real cost figure, each environment declares a small
example AWS workload in [`modules/example-workload`](modules/example-workload):

- `aws_instance` — EC2 compute on Graviton/ARM (`t4g.micro` in dev, `t4g.large` in prod)
- `aws_ebs_volume` — a gp3 data volume (20 GiB in dev, 100 GiB in prod)
- `aws_db_instance` — a PostgreSQL RDS database on Graviton (`db.t4g.micro` + 20 GiB in dev, `db.t4g.medium` + 100 GiB in prod)

Graviton instance classes are used to follow common FinOps best practice (better
price/performance than the equivalent `t3`/`x86` classes).

These are **priced, not deployed**. The AWS provider is configured with mock
credentials and `skip_*` flags (see `environments/*/providers.tf`), so
`terraform plan` and Infracost run fully offline — no AWS account, no real
credentials. The inline mock keys also override any real credentials in your
shell, so an accidental `terraform apply` fails rather than creating billable
infrastructure.

Because dev and prod are sized differently, the Infracost PR comment shows a
real monthly cost and a clear difference between environments.

## No real cloud cost

This project never provisions real infrastructure. It uses:

- `random_id` to simulate generated environment IDs
- `local_file` to simulate generated deployment metadata
- a mock-credential AWS workload that Infracost prices but Terraform never deploys

That makes it safe for public demos and interviews.

## Suggested talking points for interviews

- I separate infrastructure by environment.
- I use modules to avoid copy-paste Terraform.
- I validate and plan infrastructure changes before apply.
- I use pull request checks before deployment.
- I keep environment-specific values in tfvars files.
- I avoid storing secrets in Terraform code.
- I document the process so the team can operate it consistently.


## Sample execution

```bash
cd environments/dev
terraform init        # downloads the AWS, random, and local providers
terraform fmt -check -recursive ../..
terraform validate
terraform plan        # runs offline via the mock AWS provider; values come from terraform.tfvars

# Optional: cost estimate for both environments
infracost breakdown --config-file=../../infracost.yml
```