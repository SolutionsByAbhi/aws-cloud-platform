 resource  "aws_db_subnet_group"  "this"  {
    name             = "${var.name}-db-subnet-group"
     subnet_ids  = var.subnet_ids
 
     tags =  var.tags
 }
 
 resource "aws_db_instance"  "this"  {
    identifier                          = "${var.name}-postgres"
     engine                                =  "postgres"
    engine_version                  =  "15.3"
     instance_class                  = var.instance_class
     allocated_storage            =  var.allocated_storage
     username                            =  var.db_username
     password                            =  var.db_password
     db_subnet_group_name       =  aws_db_subnet_group.this.name
    skip_final_snapshot         =  true
    multi_az                             =  true
    storage_encrypted             =  true
    publicly_accessible         =  false
    deletion_protection         =  false
    backup_retention_period  =  7
 
    tags  =  var.tags
 }
