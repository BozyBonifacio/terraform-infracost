module "profile_site_metadata" {
  source = "../../modules/profile-site-metadata"

  environment      = var.environment
  owner            = var.owner
  application_name = var.application_name
  tags             = var.tags
}

# Example billable workload — priced by Infracost, never deployed.
# See modules/example-workload and environments/dev/providers.tf.
module "example_workload" {
  source = "../../modules/example-workload"

  environment          = var.environment
  tags                 = var.tags
  instance_type        = var.instance_type
  data_volume_size     = var.data_volume_size
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
}
