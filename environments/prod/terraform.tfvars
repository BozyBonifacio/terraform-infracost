environment      = "prod"
owner            = "Bozy Bonifacio"
application_name = "public-profile-chatbot"

tags = {
  CostCenter  = "portfolio"
  Purpose     = "terraform-process-showcase"
  Criticality = "medium"
}

# Example workload sizing — larger for prod.
instance_type        = "t3.large"
data_volume_size     = 100
db_instance_class    = "db.t3.medium"
db_allocated_storage = 100
