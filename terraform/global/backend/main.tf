terraform  {
   required_version  =  ">= 1.5.0"

    required_providers {
       aws  =  {
           source   =  "hashicorp/aws"
           version =  "~>  5.0"
       }
   }

    backend "s3"  {
       #  These  values  are placeholders;  adjust  per  environment  or use  partial  config.
       bucket                =  "aws-cloud-platform-tfstate-bootstrap"
       key                      = "global/backend/terraform.tfstate"
       region                 = "eu-central-1"
       dynamodb_table  =  "aws-cloud-platform-tf-locks"
       encrypt              =  true
    }
}

provider  "aws"  {
   region  =  "eu-central-1"
}

resource  "aws_s3_bucket"  "tf_state" {
    bucket  = "aws-cloud-platform-tfstate"

    versioning {
       enabled  =  true
   }

    server_side_encryption_configuration {
       rule  {
           apply_server_side_encryption_by_default  {
              sse_algorithm  = "AES256"
           }
       }
   }

    lifecycle {
       prevent_destroy  =  true
   }

    tags =  {
       Name  =  "tf-state"
   }
}

resource "aws_dynamodb_table"  "tf_locks"  {
   name                 = "aws-cloud-platform-tf-locks"
    billing_mode  = "PAY_PER_REQUEST"
    hash_key         =  "LockID"

    attribute  {
       name =  "LockID"
       type  =  "S"
   }

   tags  =  {
       Name  =  "tf-locks"
   }
}
