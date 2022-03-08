resource "random_password" "master_password" {
  length  = var.length_password
  special = false
}

resource "aws_db_instance" "db_rds_pg" {
  identifier = lower("${var.project_name}-${var.project_environment}")
  db_name = var.initial_db_name
  engine = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = 20
  skip_final_snapshot = true
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.security_group.id]
  port = "5432"
  username = "postgres"
  password = random_password.master_password.result
  tags = {
    project = var.project_name
    environment = var.project_environment
  }
}