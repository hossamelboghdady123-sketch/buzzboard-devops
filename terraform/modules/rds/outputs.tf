output "endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "database_name" {
  value = aws_db_instance.postgres.db_name
}

output "database_port" {
  value = aws_db_instance.postgres.port
}
