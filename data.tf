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
  image_tag       = "latest"
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

data "aws_iam_role" "sns-slack-role" {
  name = "sns-slack-role"
}

data "aws_iam_role" "test-state-machine" {
  name = "StepFunctions-MyStateMachine-019l9i03a-role-z6adgp9bq"
}

data "aws_iam_role" "blue-green-build" {
  name = "codebuild-blue-green-build-service-role"
}

data "aws_iam_role" "blue-green-deploy" {
  name = "blue-green-deploy-role"
}

data "aws_iam_role" "blue-green-codepipeline" {
  name = "AWSCodePipelineServiceRole-ap-northeast-1-blue-green-deploy-cod"
}

#===================================
#===================================
#step functions

data "aws_sfn_state_machine" "fargate" {
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