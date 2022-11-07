
resource "aws_ecs_task_definition" "task_definition" {
  family ="${var.ecsClusterName}Task"               
  network_mode="awsvpc"
  execution_role_arn= aws_iam_role.ecs_tasks_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  container_definitions = <<DEFINITION
    [
      {
        "name": "${var.container_name}",
        "memory": ${var.memory},
        "cpu": ${var.cpu},
        "image": "${var.imageURI}",
        "essential": true,
        "portMappings": [
          {
            "containerPort": ${var.containerPort},
            "protocol"     : "tcp"
          }
        ],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "container-logs",
            "awslogs-region": "us-east-1",
            "awslogs-stream-prefix": "ecs"
          }
        }
      }
    ]
    DEFINITION
   
}
resource "aws_cloudwatch_log_group" "container-logs" {
  name = "container-logs"
}