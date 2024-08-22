resource "aws_codedeploy_app" "blue-green" {
  compute_platform = "ECS"
  name             = "blue-green-deploy"
}

resource "aws_codedeploy_deployment_group" "blue-green" {
  for_each = local.aws_codedeploy_deployment_group_map_list

  app_name = aws_codedeploy_app.blue-green.name
  deployment_group_name = each.value.Name

  service_role_arn = data.aws_iam_role.blue-green-deploy.arn

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.blue-green-cluster.name
    service_name = each.value.service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [each.value.listener_arns]
      }
      target_group {
        name = each.value.first_target_group_name
      }
      target_group {
        name = each.value.second_target_group_name
      }
    }
  }
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 0
    }
  }
}