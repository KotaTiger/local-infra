resource "aws_service_discovery_http_namespace" "default" {
  name = "ecs-demo-cluster"

  tags = {
    "AmazonECSManaged" = "true"
  }
}

/*
resource "aws_service_discovery_http_namespace" "blue-green" {
  name = "blue-green-cluster"

  tags = {
    "AmazonECSManaged" = "true"
  }
}
*/