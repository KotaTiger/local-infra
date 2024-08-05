resource "aws_ecs_service" "default" {
  for_each = local.ecs_service_map_list
  name = each.value.Name
  cluster = aws_ecs_cluster.default.id

  desired_count = 1
  enable_ecs_managed_tags = true
  health_check_grace_period_seconds = 5

  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.default.arn

  deployment_circuit_breaker {
    enable   = true 
    rollback = true 
  }

  deployment_controller {
    type = "ECS" 
  }

  tags = {
    "autoStopHour"      = "20"
    "desiredCount"      = "1"
    "fargateUpdateHour" = "15"
  }

  load_balancer {
    container_name   = "fagate-demo-container" 
    container_port   = 5000 
    target_group_arn = each.value.target_group_arn
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [
      aws_security_group.ecs-service.id
    ]
    subnets          = [
      aws_subnet.main["private-1a"].id,
      aws_subnet.main["private-1c"].id
    ]
  }
}

resource "aws_ecs_service" "blue-green" {
  for_each = local.ecs_service_blue_green_map_list
  name = each.value.Name
  cluster = aws_ecs_cluster.default.id

  desired_count = 1
  enable_ecs_managed_tags = true
  health_check_grace_period_seconds = 5

  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.blue-green.arn

  deployment_controller {
    type = "CODE_DEPLOY" 
  }

  tags = {
    "autoStopHour"      = "20"
    "desiredCount"      = "1"
    "fargateUpdateHour" = "15"
  }

  load_balancer {
    container_name   = "blue-green-task" 
    container_port   = 5000 
    target_group_arn = each.value.first_target_group_arn
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [
      aws_security_group.ecs-blue-green.id
    ]
    subnets          = [
      aws_subnet.main["private-1a"].id,
      aws_subnet.main["private-1c"].id
    ]
  }
}