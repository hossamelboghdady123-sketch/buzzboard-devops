resource "aws_db_subnet_group" "this" {

  name = "${var.project_name}-${var.environment}"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }

}
resource "aws_db_instance" "postgres" {

  identifier = "${var.project_name}-${var.environment}-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class = var.instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [
    var.rds_security_group_id
  ]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 1

  skip_final_snapshot = true

  deletion_protection = false

  storage_encrypted = true
}
