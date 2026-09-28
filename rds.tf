resource "random_password" "master_password" {
  length  = var.length_password
  special = false
}

resource "aws_db_instance" "db_rds_pg" {
  identifier     = lower(local.project)
  db_name        = var.initial_db_name
  engine         = "postgres"
  engine_version = var.engine_version

  instance_class        = var.instance_class
  storage_type          = var.storage_type
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = var.storage_encrypted

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${lower(local.project)}-final"
  publicly_accessible       = var.publicly_accessible
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window

  vpc_security_group_ids = [aws_security_group.security_group_rds.id]

  port     = "5432"
  username = var.initial_username
  password = random_password.master_password.result


  tags = {
    project     = var.project_name
    environment = var.project_environment
  }
}
