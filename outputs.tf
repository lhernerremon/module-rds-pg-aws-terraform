output "identifier" {
  value = aws_db_instance.db_rds_pg.identifier
}

output "address" {
  value = aws_db_instance.db_rds_pg.address
}

output "port" {
  value = aws_db_instance.db_rds_pg.port
}

output "username" {
  value = aws_db_instance.db_rds_pg.username
}

output "security_group_id" {
  value = aws_security_group.security_group_rds.id
}
