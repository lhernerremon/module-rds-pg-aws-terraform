# AWS RDS Terraform module

This Terraform module will create an RDS instance with postgres and bind the EC2 instance's security group as a database security group rule. It will also create the rules for ingress and egress of the security group.

## Usage

```hcl
provider "aws" {
  region = "us-east-2"
  profile = "project"
}

module "ec2_instance" {
  ...
}

module "rds_pg" {
  source  = "github.com/lhernerremon/module-rds-pg-aws-terraform?ref=v1.0.1"
  project_name = "project"
  project_environment = "develop"
  initial_db_name = "db_initial"
  engine_version = "16"
  instance_class = "db.t3.micro"
  
  source_security_group_id = module.ec2_instance.security_group_id # module.<name_module_ec2>.<output_security_group_id>
}
```
**Note:** The value `source_security_group_id` will be the value of the security `group id` of the EC2 instance that will be obtained as `output`.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | Project's name | `string` | `""` | yes |
| project_environment | Project environment | `string` | `""` | yes |
| initial_db_name | Name of the initial database to use | `string` | `""` | yes |
| initial_username | Name of the initial username to use | `string` | `"postgres"` | no |
| source_security_group_id | Security group ID to allow access | `string` | `""` | yes |
| engine_version | PostgreSQL version | `string` | `"15.7"` | no |
| instance_class | DB Instance Type | `string` | `"db.t3.micro"` | no |
| allocated_storage | The amount of allocated storage | `number` | `20` | no |
| backup_retention_period | The backup retention period | `number` | `7` | no |
| backup_window | Automated backups occur daily during the preferred backup window | `string` | `"05:00-05:30"` | no |
| skip_final_snapshot | A value that indicates whether a final DB snapshot is created before the DB instance is deleted | `bool` | `true` | no |
| publicly_accessible | This parameter lets you designate whether there is public access to the DB instance | `bool` | `false` | no |


## Resources that return

| Extension | Folder | Description |
|------|-------------|:--------:|
| address.txt | ./rds | Text file with the hostname of the RDS instance |
| username.txt | ./rds | Text file with master user |
| password.txt | ./rds | Text file with the password |