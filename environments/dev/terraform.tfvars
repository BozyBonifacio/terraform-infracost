environment      = "dev"
owner            = "Bozy Bonifacio"
application_name = "public-profile-chatbot"

tags = {
  CostCenter  = "portfolio"
  Purpose     = "terraform-process-showcase"
  Criticality = "low"
}

# Example workload sizing — small for dev. Graviton (t4g) per FinOps policy.
instance_type        = "t4g.micro"
data_volume_size     = 20
db_instance_class    = "db.t4g.micro"
db_allocated_storage = 20
