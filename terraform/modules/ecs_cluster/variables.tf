variable  "name"  {
   type               =  string
   description  =  "Name prefix  for  ECS  resources"
}

variable  "vpc_id"  {
   type               = string
    description  = "VPC  ID"
}

variable "private_subnet_ids"  {
    type              =  list(string)
   description  =  "Private  subnet IDs  for  ECS  tasks"
}

variable  "public_subnet_ids"  {
   type               = list(string)
    description  = "Public  subnet  IDs  for  ALB"
}

variable  "container_port"  {
   type              =  number
    default         = 8080
}

variable  "cpu" {
    type              =  number
   default         =  256
}

variable "memory"  {
    type              =  number
   default         =  512
}

variable  "image"  {
   type               =  string
   description  =  "Container image  for  the  app"
}

variable  "execution_role_arn"  {
   type               = string
    description  = "ECS  task  execution  role  ARN"
}

variable  "task_role_arn"  {
   type              =  string
    description =  "ECS  task  role  ARN"
}

variable  "tags"  {
   type              =  map(string)
    default         = {}
}
