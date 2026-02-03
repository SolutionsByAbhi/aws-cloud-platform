terraform  {
   required_version  =  ">=  1.5.0"

    required_providers  {
       aws =  {
           source   =  "hashicorp/aws"
           version  = "~>  5.0"
       }
    }
}

provider  "aws"  {
   region  =  "eu-central-1"
}

#  Example:  ECS task  execution  role
resource  "aws_iam_role" "ecs_task_execution"  {
    name =  "ecsTaskExecutionRole"

   assume_role_policy  =  jsonencode({
       Version  =  "2012-10-17"
       Statement =  [
           {
              Effect  =  "Allow"
              Principal  = {
                  Service  =  "ecs-tasks.amazonaws.com"
              }
              Action  =  "sts:AssumeRole"
          }
       ]
    })
}

resource  "aws_iam_role_policy_attachment"  "ecs_task_execution_policy"  {
   role             = aws_iam_role.ecs_task_execution.name
    policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
