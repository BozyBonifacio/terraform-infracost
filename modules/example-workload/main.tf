# Example billable workload used to demonstrate Infracost cost estimates.
#
# IMPORTANT: This is never applied to a real cloud account. The environments
# configure the AWS provider with mock credentials and skip_* flags, so
# `terraform plan` runs fully offline and Infracost prices these resources from
# their definitions without contacting AWS. Do not run `terraform apply` with
# real credentials unless you intend to create (and pay for) this infrastructure.

locals {
  name_prefix = "${var.environment}-example"

  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Component   = "example-workload"
  })
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-app"
  })
}

resource "aws_ebs_volume" "data" {
  availability_zone = var.availability_zone
  size              = var.data_volume_size
  type              = "gp3"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-data"
  })
}

resource "aws_db_instance" "app" {
  identifier        = "${local.name_prefix}-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  storage_type      = "gp3"

  username                    = "appadmin"
  manage_master_user_password = true
  skip_final_snapshot         = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db"
  })
}
