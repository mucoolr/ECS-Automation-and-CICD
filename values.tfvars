region             = "us-east-1"
ecsClusterName     = "ecs-cluster"
tags               = { "Purpose" : "assingment" }
name_ecs_service   = "ecs-service"
taskDesiredCount   = 1
cpu                = 512
memory             = 1024
container_name     = "climate"
containerPort      = 8080
imageURI           = "616102230795.dkr.ecr.us-east-1.amazonaws.com/climate:latest"








