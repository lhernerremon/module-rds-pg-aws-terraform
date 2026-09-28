variable "project_name" {
  type = string
}

variable "project_environment" {
  type    = string
  default = "development"
}

variable "identifier" {
  type    = string
  default = null
}

variable "initial_db_name" {
  type     = string
  nullable = false
}

variable "initial_username" {
  type     = string
  nullable = false
}

variable "source_security_group_id" {
  type = string
}

variable "engine_version" {
  type    = string
  default = "17"
}

variable "instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = true
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
  default = 22
}
