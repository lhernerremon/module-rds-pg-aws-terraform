locals {
  project = coalesce(var.identifier, trimspace("${var.project_name}-${var.project_environment}"))
}
