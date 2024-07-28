variable "project_name" {
  type = string
}

variable "project_environment" {
  type    = string
  default = "development"
}

variable "initial_db_name" {
  type = string
}

variable "source_security_group_id" {
  type = string
}

variable "engine_version" {
  type    = string
  default = "12.9"
}

variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "backup_window" {
  type    = string
  default = "05:00-05:30"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "publicly_accessible" {
  type    = bool
  default = false
}


variable "length_password" {
  type    = number
  default = 16
}
