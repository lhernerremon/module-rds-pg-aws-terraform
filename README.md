# AWS RDS Terraform module

This Terraform module will create an RDS instance with postgres and bind the EC2 instance's security group as a database security group rule. The security group only gets an ingress rule on port 5432 from that EC2 security group.

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
  source  = "github.com/lhernerremon/module-rds-pg-aws-terraform?ref=v2.0.0"
  project_name = "project"
  project_environment = "develop"
  initial_db_name = "db_initial"
  initial_username = "app_user"

  source_security_group_id = module.ec2_instance.security_group_id # module.<name_module_ec2>.<output_security_group_id>
}
```

**Note:** The value `source_security_group_id` will be the value of the security `group id` of the EC2 instance that will be obtained as `output`.

## Inputs

| Name                     | Description                                                                                                     | Type     | Default          | Required |
| ------------------------ | --------------------------------------------------------------------------------------------------------------- | -------- | ---------------- | :------: |
| project_name             | Project's name                                                                                                  | `string` |                  |   yes    |
| project_environment      | Project environment                                                                                             | `string` | `"development"`  |    no    |
| identifier               | Name of the instance (lowercased), security group and files. Defaults to `<project_name>-<project_environment>` | `string` | `null`           |    no    |
| initial_db_name          | Name of the database created with the instance                                                                  | `string` |                  |   yes    |
| initial_username         | Master user, the one the app connects with. Use a name other than `postgres`                                    | `string` |                  |   yes    |
| source_security_group_id | Security group ID to allow access                                                                               | `string` |                  |   yes    |
| engine_version           | PostgreSQL version                                                                                              | `string` | `"17"`           |    no    |
| instance_class           | DB Instance Type                                                                                                | `string` | `"db.t4g.micro"` |    no    |
| storage_type             | Storage type                                                                                                    | `string` | `"gp3"`          |    no    |
| allocated_storage        | Initial storage in GiB (20 is the gp3 minimum)                                                                  | `number` | `20`             |    no    |
| max_allocated_storage    | Storage autoscaling limit in GiB. `0` turns it off                                                              | `number` | `100`            |    no    |
| storage_encrypted        | Encrypts the storage with the `aws/rds` key                                                                     | `bool`   | `true`           |    no    |
| deletion_protection      | Blocks deleting the instance until it is set to `false`                                                         | `bool`   | `true`           |    no    |
| backup_retention_period  | The backup retention period                                                                                     | `number` | `7`              |    no    |
| backup_window            | Automated backups occur daily during the preferred backup window                                                | `string` | `"05:00-05:30"`  |    no    |
| skip_final_snapshot      | Only when Terraform deletes the instance: skips the final snapshot. When `false`, it is `<identifier>-final`    | `bool`   | `true`           |    no    |
| publicly_accessible      | This parameter lets you designate whether there is public access to the DB instance                             | `bool`   | `false`          |    no    |
| length_password          | Length of the generated master password                                                                         | `number` | `22`             |    no    |

## Outputs

| Name              | Description                        |
| ----------------- | ---------------------------------- |
| identifier        | Identifier of the RDS instance     |
| address           | Hostname of the RDS instance       |
| port              | Port of the RDS instance           |
| username          | Master user                        |
| security_group_id | Security group of the RDS instance |

## Resources that return

| Extension    | Folder |                   Description                   |
| ------------ | ------ | :---------------------------------------------: |
| address.txt  | ./rds  | Text file with the hostname of the RDS instance |
| username.txt | ./rds  |           Text file with master user            |
| password.txt | ./rds  |           Text file with the password           |

**Note:** `password.txt` and the `terraform.tfstate` hold the master password in plain text. Keep both out of version control.

## Master user

The app connects with the master user, which owns `initial_db_name` and is a member of `rds_superuser`. cookiecutter-django's `backup` and `restore` scripts refuse to run as `postgres`, so pick another name. It can't be changed later without replacing the instance.

Use 1–16 lowercase letters, digits or underscores, starting with a letter. AWS documents a 16-character limit and rejects reserved words such as `user`, so the random `POSTGRES_USER` that cookiecutter-django generates doesn't fit.

## Deleting the instance

This module is meant to create the instance. Delete it from the AWS console: Modify → turn off deletion protection → Delete (the console offers a final snapshot). Once the deletion finishes, remove the module block and run `apply`: Terraform sees the instance is gone, deletes its security group and `rds/` files, and doesn't recreate it. Not before: removing the block first deletes the ingress rule and then fails on the deletion protection, leaving the app without access.
