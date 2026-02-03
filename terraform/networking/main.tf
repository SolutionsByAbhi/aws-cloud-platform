terraform {
    required_version  = ">=  1.5.0"

   required_providers  {
       aws  =  {
          source    =  "hashicorp/aws"
          version  =  "~>  5.0"
       }
   }

   backend  "s3"  {
       bucket                =  "aws-cloud-platform-tfstate"
       key                      = "networking/${var.env}/terraform.tfstate"
       region                 = "eu-central-1"
       dynamodb_table  =  "aws-cloud-platform-tf-locks"
       encrypt              =  true
    }
}

provider  "aws"  {
   region  =  var.region
}

locals  {
   name  =  "aws-platform-${var.env}"
   tags  =  {
       Environment  = var.env
       Project         =  "aws-cloud-platform"
    }
}

module  "vpc"  {
   source  =  "../modules/vpc"

    name                                =  local.name
   cidr_block                      =  "10.0.0.0/16"
   public_subnet_cidrs      = ["10.0.1.0/24",  "10.0.2.0/24"]
    private_subnet_cidrs   =  ["10.0.11.0/24",  "10.0.12.0/24"]
   isolated_subnet_cidrs  =  ["10.0.21.0/24",  "10.0.22.0/24"]
   azs                                  =  ["eu-central-1a",  "eu-central-1b"]
   tags                                 = local.tags
}
