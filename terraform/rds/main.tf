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
       key                      =  "rds/${var.env}/terraform.tfstate"
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

module  "rds"  {
   source  =  "../modules/rds_postgres"

   name               = local.name
    vpc_id           = data.terraform_remote_state.networking.outputs.vpc_id
    subnet_ids   =  data.terraform_remote_state.networking.outputs.isolated_subnet_ids
    db_username =  var.db_username
    db_password =  var.db_password
    tags              =  local.tags
}
