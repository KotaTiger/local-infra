resource "aws_ecs_cluster" "default" {
  name = aws_service_discovery_http_namespace.default.name

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.default.arn
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

/*
resource "aws_ecs_cluster" "blue-green-cluster" {
  name = aws_service_discovery_http_namespace.blue-green.name

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.blue-green.arn
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
*/
