variable "environment" {
  description = "Environment name."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "EC2 instance type for the example workload."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance. Placeholder value; nothing is ever deployed."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "availability_zone" {
  description = "Availability zone for the data volume."
  type        = string
  default     = "us-east-1a"
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
