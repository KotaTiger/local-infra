resource "aws_ecs_task_definition" "default" {
  family = "fargate-demo-task-definition"
  container_definitions = jsonencode([
    {
      "name" : "fagate-demo-container",
      "image" : data.aws_ecr_repository.flask-demo-app.repository_url,
      "cpu" : 1024,
      "portMappings" : [
        {
          "name" : "5000",
          "containerPort" : 5000,
          "hostPort" : 5000,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "essential" : true,
      "environment" : [],
      "environmentFiles" : [],
      "mountPoints" : [],
      "volumesFrom" : [],
      "ulimits" : [],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : "/ecs/",
          "awslogs-create-group" : "true",
          "awslogs-region" : "ap-northeast-1",
          "awslogs-stream-prefix" : "ecs"
        },
        "secretOptions" : []
      },
      "systemControls" : []
    }
  ])
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 3072
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn

  network_mode             = "awsvpc"

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

}