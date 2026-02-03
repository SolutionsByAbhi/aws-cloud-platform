#  Architecture  Decisions

## Terraform  +  Ansible

Terraform is  used  for  infrastructure  lifecycle (VPC,  ECS,  RDS,  IAM).  Ansible is  used  for  host-level  configuration (bastion)  and  orchestration  of  application deployment  (ECS  task  updates).

##  ECS  Fargate  vs  EC2

Fargate  is  chosen  to reduce  operational  overhead  and  focus on  application-level  concerns.  It  also simplifies  capacity  management  and  scaling.

##  RDS  PostgreSQL

Managed  PostgreSQL  provides  durability,  backups, and  Multi-AZ  support  without  managing database  servers  directly.

## Remote  State

Terraform  state is  stored  in  S3  with DynamoDB  locking  to  support  team workflows  and  prevent  concurrent  modification.
