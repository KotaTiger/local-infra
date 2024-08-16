resource "aws_sns_topic" "slack" {
  name         = "Slack"
  display_name = "Slack通知"
}