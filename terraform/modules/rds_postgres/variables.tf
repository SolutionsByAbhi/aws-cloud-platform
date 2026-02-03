 variable  "name"  {
    type               = string
     description  = "Name  prefix  for  RDS"
 }

 variable  "vpc_id"  {
    type               = string
     description  = "VPC  ID"
 }
 
 variable "subnet_ids"  {
     type              =  list(string)
    description  =  "Subnet  IDs for  RDS  subnet  group"
 }

 variable  "db_username"  {
    type               = string
     description  = "DB  master  username"
 }
 
variable  "db_password"  {
    type               =  string
    description  =  "DB master  password"
     sensitive     =  true
 }

 variable  "instance_class"  {
    type               = string
     default         =  "db.t3.micro"
}
 
 variable  "allocated_storage"  {
    type              =  number
     default         = 20
 }
 
 variable  "tags" {
     type              =  map(string)
    default         =  {}
 }
