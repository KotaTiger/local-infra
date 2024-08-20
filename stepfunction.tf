resource "aws_sfn_state_machine" "test-state-machine" {
  name     = "test-state-machine"
  role_arn = data.aws_iam_role.test-state-machine.arn
  definition = templatefile("stepfunctions/test_stepfunction.json", {
    testFunction = aws_lambda_function.test_lambda.arn
    }
  )
}