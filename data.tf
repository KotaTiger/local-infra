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

data "aws_iam_role" "fargate-event-bridge" {
  name = "Amazon_EventBridge_Scheduler_Fargate_Update_Role"
}

data "aws_iam_role" "ecs-access-policy" {
  name = "ECSAccessListPolicy"
} 

#===================================
#===================================
#step functions

data "aws_sfn_state_machine" "fargate"{
  name = "MyStateMachine-ns2k1lwx5"
}

#===================================
#===================================
#Lambda
data "archive_file" "test_python" {
  type        = "zip"
  source_dir  = "./lambda/testFunction_python"
  output_path = "./lambda/testFunction_python/testFunction_python.zip"
}