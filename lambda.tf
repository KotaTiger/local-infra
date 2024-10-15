resource "aws_lambda_function" "test_lambda" {
  role          = data.aws_iam_role.ecs-access-policy.arn
  function_name = "testFunction_python"
  filename      = data.archive_file.test_python.output_path
  handler       = "testFunction_python.lambda_handler"

  timeout = 900
  runtime = "python3.10"

  /*
  vpc_config {
    subnet_ids = [
      aws_subnet.main["public-1a"].id,
      aws_subnet.main["public-1c"].id
    ]
    security_group_ids = [
      aws_default_security_group.default.id
    ]
  }
  */
}
