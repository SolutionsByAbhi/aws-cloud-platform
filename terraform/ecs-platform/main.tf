terraform  {
   required_version  =  ">=  1.5.0"

    required_providers  {
       aws =  {
           source   =  "hashicorp/aws"
           version  = "~>  5.0"
       }
    }

    backend  "s3" {
       bucket                 = "aws-cloud-platform-tfstate"
       key                      =  "ecs-platform/${var.env}/terraform.tfstate"
       region                =  "eu-central-1"
       dynamodb_table  = "aws-cloud-platform-tf-locks"
       encrypt               =  true
   }
}

provider  "aws"  {
   region  =  var.region
}

data  "terraform_remote_state"  "networking"  {
   backend  =  "s3"

   config  =  {
       bucket                =  "aws-cloud-platform-tfstate"
       key                     =  "networking/${var.env}/terraform.tfstate"
       region                =  "eu-central-1"
       dynamodb_table  =  "aws-cloud-platform-tf-locks"
   }
}

locals  {
    name =  "aws-platform-${var.env}"
    tags =  {
       Environment  =  var.env
       Project         =  "aws-cloud-platform"
   }
}

#  In  a  real  setup, these  would  come  from  global IAM
data  "aws_iam_role"  "ecs_task_execution"  {
   name  =  "ecsTaskExecutionRole"
}

data  "aws_iam_role"  "ecs_task" {
    name  = "ecsTaskRole"
}

module  "ecs_cluster" {
    source  = "../modules/ecs_cluster"

    name                         =  local.name
   vpc_id                      = data.terraform_remote_state.networking.outputs.vpc_id
    private_subnet_ids  = data.terraform_remote_state.networking.outputs.private_subnet_ids
    public_subnet_ids   =  data.terraform_remote_state.networking.outputs.public_subnet_ids
    container_port         = 8080
    cpu                             = 256
    memory                       =  512
   image                          = var.image
    execution_role_arn  = data.aws_iam_role.ecs_task_execution.arn
    task_role_arn           = data.aws_iam_role.ecs_task.arn
    tags                           =  local.tags
}
