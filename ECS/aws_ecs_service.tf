 resource "aws_ecs_service" "service" {
  name            = "${var.ecsClusterName}"
  cluster         = aws_ecs_cluster.cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition.id
  desired_count   = "${var.taskDesiredCount}"
  deployment_circuit_breaker {
       enable=true
       rollback=true
    }
 

 network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.staging.id]
    subnets          = var.subnets
  }

   tags = var.tags

}
