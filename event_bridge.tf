resource "aws_scheduler_schedule" "fargate-rolling-update" {
    schedule_expression = "cron(20 7 ? * MON *)"
    schedule_expression_timezone = "UTC"

    flexible_time_window {
        mode = "OFF"
    }

    target {
        input = jsonencode({ "clusterName": "ecs-demo-cluster" })
        arn = data.aws_sfn_state_machine.fargate.arn
        role_arn = data.aws_iam_role.fargate-event-bridge.arn
    }
}