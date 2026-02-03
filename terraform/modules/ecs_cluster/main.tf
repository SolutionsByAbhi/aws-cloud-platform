resource  "aws_ecs_cluster"  "this"  {
   name  =  "${var.name}-ecs-cluster"

   setting  {
       name   =  "containerInsights"
       value  =  "enabled"
   }

   tags  =  var.tags
}

resource  "aws_cloudwatch_log_group"  "app"  {
   name                         =  "/ecs/${var.name}-app"
    retention_in_days =  30

   tags  =  var.tags
}

resource  "aws_lb"  "app"  {
   name                           =  "${var.name}-alb"
   internal                    =  false
   load_balancer_type  =  "application"
   security_groups        = []
    subnets                     =  var.public_subnet_ids

   tags  =  var.tags
}

resource  "aws_lb_target_group"  "app"  {
   name         =  "${var.name}-tg"
   port         =  var.container_port
    protocol =  "HTTP"
    vpc_id     =  var.vpc_id

   health_check  {
       path                             = "/"
       healthy_threshold      =  3
       unhealthy_threshold =  3
       timeout                        = 5
       interval                      =  30
       matcher                       =  "200-399"
   }

    tags =  var.tags
}

resource "aws_lb_listener"  "http"  {
   load_balancer_arn  =  aws_lb.app.arn
   port                          = 80
    protocol                  =  "HTTP"

    default_action  {
       type                       =  "forward"
       target_group_arn  = aws_lb_target_group.app.arn
    }
}

resource  "aws_ecs_task_definition"  "app"  {
   family                                  =  "${var.name}-app"
   network_mode                        =  "awsvpc"
   requires_compatibilities  =  ["FARGATE"]
   cpu                                        = var.cpu
    memory                                  =  var.memory
   execution_role_arn             =  var.execution_role_arn
   task_role_arn                      = var.task_role_arn

    container_definitions =  jsonencode([
       {
           name           = "app"
           image         =  var.image
          essential  =  true
           portMappings =  [
              {
                  containerPort  =  var.container_port
                  protocol          =  "tcp"
              }
           ]
           logConfiguration =  {
              logDriver  =  "awslogs"
              options  =  {
                  awslogs-group                =  aws_cloudwatch_log_group.app.name
                 awslogs-region               =  "eu-central-1"
                 awslogs-stream-prefix  =  "ecs"
              }
           }
       }
   ])

   tags  =  var.tags
}

resource  "aws_ecs_service"  "app"  {
   name                      =  "${var.name}-app-svc"
   cluster                =  aws_ecs_cluster.this.id
   task_definition  =  aws_ecs_task_definition.app.arn
   desired_count      =  2
   launch_type         =  "FARGATE"

   network_configuration  {
       subnets                =  var.private_subnet_ids
       assign_public_ip  = false
       security_groups    =  []
   }

   load_balancer  {
       target_group_arn  =  aws_lb_target_group.app.arn
       container_name     =  "app"
       container_port     =  var.container_port
    }

    deployment_minimum_healthy_percent  = 50
    deployment_maximum_percent                =  200

   tags  =  var.tags
}
