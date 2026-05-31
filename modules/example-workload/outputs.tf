output "instance_id" {
  description = "ID of the example EC2 instance."
  value       = aws_instance.app.id
}

output "data_volume_id" {
  description = "ID of the example EBS data volume."
  value       = aws_ebs_volume.data.id
}

output "db_identifier" {
  description = "Identifier of the example RDS instance."
  value       = aws_db_instance.app.identifier
}
