resource "aws_lb" "rolling-update" {
  for_each = local.alb_map_list

  name = each.value.Name

  security_groups = [
    aws_security_group.rolling-update.id,
    aws_default_security_group.default.id
  ]

  subnets = [
    aws_subnet.main["public-1a"].id,
    aws_subnet.main["public-1c"].id
  ]
}

resource "aws_lb_listener" "rolling-update" {
  for_each          = local.aws_lb_listner_map_list
  load_balancer_arn = each.value.target_id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = each.value.target_group_arn
  }
}

resource "aws_lb" "blue-green" {
  for_each = local.alb_map_blue_green_list

  name = each.value.Name

  security_groups = [
    aws_security_group.ecs-blue-green.id,
    aws_default_security_group.default.id
  ]

  subnets = [
    aws_subnet.main["public-1a"].id,
    aws_subnet.main["public-1c"].id
  ]
}

resource "aws_lb_listener" "blue-green" {
  for_each          = local.aws_lb_listner_blue_green_map_list
  load_balancer_arn = each.value.target_id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = each.value.target_group_arn
  }
}

