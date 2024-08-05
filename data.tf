#===================================
#===================================
#ecr

data "aws_ecr_repository" "flask-demo-app" {
  name = "flask-demo-app"
}

data "aws_ecr_repository" "blue-green-app" {
  name = "blue-green-deploy-app"
}

data "aws_ecr_image" "blue-green-app" {
  repository_name = "blue-green-deploy-app"
  image_tag = "latest"
}


#===================================
#===================================
#iam role

data "aws_iam_role" "ecs-task-execution-role" {
  name = "ecsTaskExecutionRole"
}