# Mock AWS provider configuration.
#
# This project is a safe showcase: it never provisions real infrastructure.
# The mock credentials and skip_* flags let `terraform plan` (and Infracost)
# run fully offline, with no AWS account or real credentials required. The
# inline mock keys also override any real credentials in your environment, so
# an accidental `terraform apply` fails instead of creating billable resources.
provider "aws" {
  region = "us-east-1"

  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}
