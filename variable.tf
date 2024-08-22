variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "slack_channel_id" {
  description = "Slack channel id"
  type        = string
  sensitive   = true
}

variable "slack_team_id" {
  description = "Slack team id"
  type        = string
  sensitive   = true
}

variable "codepipeline_s3" {
  description = "CodePipeline S3 Name"
  type        = string
  sensitive   = true
}