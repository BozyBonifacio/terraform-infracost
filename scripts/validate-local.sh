#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

terraform -chdir="$ROOT_DIR" fmt -check -recursive

for env in dev prod; do
  echo "==> Validating $env"
  terraform -chdir="$ROOT_DIR/environments/$env" init -backend=false
  terraform -chdir="$ROOT_DIR/environments/$env" validate
  terraform -chdir="$ROOT_DIR/environments/$env" plan -var-file="terraform.tfvars" -out="$env.tfplan"
done

# Optional cost estimate. Runs only if the Infracost CLI is installed and an
# API key is configured (INFRACOST_API_KEY env var or `infracost configure`).
if command -v infracost >/dev/null 2>&1; then
  echo "==> Infracost cost estimate"
  infracost breakdown --config-file="$ROOT_DIR/infracost.yml"
else
  echo "==> Skipping Infracost (CLI not installed). See https://www.infracost.io/docs/"
fi
