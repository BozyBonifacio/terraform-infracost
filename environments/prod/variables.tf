variable "environment" {
  description = "Environment name."
  type        = string
}

variable "owner" {
  description = "Owner of the application."
  type        = string
}

variable "application_name" {
  description = "Application name."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}

# --- Example workload sizing (priced by Infracost, never deployed) ---

variable "instance_type" {
  description = "EC2 instance type for the example workload."
  type        = string
}

variable "data_volume_size" {
  description = "Size (GiB) of the attached EBS data volume."
  type        = number
}

variable "db_instance_class" {
  description = "RDS instance class for the example database."
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage (GiB) for the RDS database."
  type        = number
}
