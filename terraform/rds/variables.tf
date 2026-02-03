 variable  "env"  {
    type               = string
     description  = "Environment  name"
 }
 
 variable "region"  {
     type              =  string
    default         =  "eu-central-1"
 }
 
variable  "db_username"  {
    type               =  string
    description  =  "DB master  username"
 }
 
 variable "db_password"  {
     type              =  string
    description  =  "DB  master password"
     sensitive     =  true
 }
