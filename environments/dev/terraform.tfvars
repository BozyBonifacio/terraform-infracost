environment      = "dev"
owner            = "Bozy Bonifacio"
application_name = "public-profile-chatbot"

tags = {
  CostCenter  = "portfolio"
  Purpose     = "terraform-process-showcase"
  Criticality = "low"
}

# Example workload sizing — small for dev.
instance_type        = "t3.micro"
data_volume_size     = 20
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
