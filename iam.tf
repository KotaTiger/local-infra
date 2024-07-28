resource "aws_iam_role" "ecs-task-execution-role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole"
        "Principal" : {
          Service = "ecs-tasks.amazonaws.com"
        },
        Sid : ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-attach" {
    role = aws_iam_role.ecs-task-execution-role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}