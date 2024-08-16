resource "aws_lb_target_group" "default" {
  for_each    = local.ecs_tg_list
  name        = each.value.Name
  target_type = "ip"
  port        = 5000
  vpc_id      = aws_vpc.main.id
  protocol    = "HTTP"

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}