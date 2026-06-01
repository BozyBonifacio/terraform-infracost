output "deployment_id" {
  value = module.profile_site_metadata.deployment_id
}

output "metadata_file" {
  value = module.profile_site_metadata.metadata_file
}

output "tags" {
  value = module.profile_site_metadata.tags
}

output "example_instance_id" {
  value = module.example_workload.instance_id
}

output "example_db_identifier" {
  value = module.example_workload.db_identifier
}
