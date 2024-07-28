resource "local_file" "rds_pg_address" {
  filename = "rds/${local.project}-address.txt"
  content  = aws_db_instance.db_rds_pg.address
}

resource "local_file" "rds_pg_username" {
  filename = "rds/${local.project}-username.txt"
  content  = aws_db_instance.db_rds_pg.username
}

resource "local_file" "rds_pg_password" {
  filename = "rds/${local.project}-password.txt"
  content  = random_password.master_password.result
}
