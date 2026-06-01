environment      = "prod"
owner            = "Bozy Bonifacio"
application_name = "public-profile-chatbot"

tags = {
  CostCenter  = "portfolio"
  Purpose     = "terraform-process-showcase"
  Criticality = "medium"
}

# Example workload sizing — larger for prod. Graviton (t4g) per FinOps policy.
instance_type        = "t4g.large"
data_volume_size     = 100
db_instance_class    = "db.t4g.medium"
db_allocated_storage = 100
