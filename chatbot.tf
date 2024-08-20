resource "aws_chatbot_slack_channel_configuration" "fargate" {
  configuration_name = "fargate_stepfunction"
  iam_role_arn       = data.aws_iam_role.sns-slack-role.arn
  slack_channel_id   = var.slack_channel_id
  slack_team_id      = var.slack_team_id

  logging_level = "INFO"

  sns_topic_arns = [
    aws_sns_topic.slack.arn,
  ]

  tags = {
    Name = "fargate_stepfunction"
  }
}