#===================================
#===================================
#subnet
locals {
  subnet_map_list = {
    public-1a = {
      name              = "public-1a"
      availability_zone = "ap-northeast-1a"
      cidr_block        = "10.0.0.0/20"
    }
    public-1c = {
      name              = "public-1c"
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.16.0/20"
    }
    private-1a = {
      name              = "private-1a"
      availability_zone = "ap-northeast-1a"
      cidr_block        = "10.0.64.0/20"
    }
    private-1c = {
      name              = "private-1c"
      availability_zone = "ap-northeast-1c"
      cidr_block        = "10.0.80.0/20"
    }
  }
}


#===================================
#===================================
#elastic ip
locals {
  elastic_ip_map_list = {
    eip_01 = {
      Name = "eip_01"
    }
    eip_02 = {
      Name = "eip_02"
    }
  }
}



#===================================
#===================================
#nat gateway
locals {
  natgateway_map_list = {
    ngw-1a = {
      eip_name  = aws_eip.main["eip_01"]
      subnet_id = aws_subnet.main["public-1a"].id
      Name      = "ngw-1a"
    }
    ngw-1c = {
      eip_name  = aws_eip.main["eip_02"]
      subnet_id = aws_subnet.main["public-1c"].id
      Name      = "ngw-1c"
    }
  }
}


#===================================
#===================================
#aws_route_table_association(public)
locals {
  route_table_association_map_list = {
    rt_public-01 = {
      subnet_id = aws_subnet.main["public-1a"].id
    }
    rt_public-02 = {
      subnet_id = aws_subnet.main["public-1c"].id
    }
  }
}

#===================================
#===================================
#aws_route_table_association(private)
locals {
  private_route_table_association_map_list = {
    rt_private-01 = {
      subnet_id      = aws_subnet.main["private-1a"].id
      route_table_id = aws_route_table.private["rt_private-01"].id
    }
    rt_private-02 = {
      subnet_id      = aws_subnet.main["private-1c"].id
      route_table_id = aws_route_table.private["rt_private-02"].id
    }
  }
}


#===================================
#===================================
#route_table(private)
locals {
  route_table_map_list = {
    rt_private-01 = {
      natgw_id = aws_nat_gateway.main["ngw-1a"].id
      Name     = "rt_private-01"
    }
    rt_private-02 = {
      natgw_id = aws_nat_gateway.main["ngw-1c"].id
      Name     = "rt_private-02"
    }
  }
}


#===================================
#===================================
#alb
locals {
  alb_map_list = {
    ecs_fargate_alb01 = {
      Name = "ecs-fargate-alb01"
    }
    ecs_fargate_alb02 = {
      Name = "ecs-fargate-alb02"
    }
  }
}

locals {
  alb_map_blue_green_list = {
    ecs_blue_green_alb01 = {
      Name = "ecs-blue-green-alb01"
    }
    ecs_blue_green_alb02 = {
      Name = "ecs-blue-green-alb02"
    }
  }
}

#===================================
#===================================
#aws_lb_target_group
locals {
  ecs_tg_list = {
    ecs_tg_01 = {
      Name = "ecs-tg-1"
    }
    ecs_tg_02 = {
      Name = "ecs-tg-2"
    }
    ecs_tg_03 = {
      Name = "ecs-tg-3"
    }
    ecs_tg_04 = {
      Name = "ecs-tg-4"
    }
    ecs_tg_05 = {
      Name = "ecs-tg-5"
    }
    ecs_tg_06 = {
      Name = "ecs-tg-6"
    }
  }
}

#===================================
#===================================
#aws_lb_listner
locals {
  aws_lb_listner_map_list = {
    aws_lb_listner_1 = {
      target_group_arn = aws_lb_target_group.default["ecs_tg_01"].arn
      target_id        = aws_lb.rolling-update["ecs_fargate_alb01"].arn
    }
    aws_lb_listner_2 = {
      target_group_arn = aws_lb_target_group.default["ecs_tg_02"].arn
      target_id        = aws_lb.rolling-update["ecs_fargate_alb02"].arn
    }
  }
}

locals {
  aws_lb_listner_blue_green_map_list = {
    aws_lb_listner_1 = {
      target_group_arn = aws_lb_target_group.default["ecs_tg_03"].arn
      target_id        = aws_lb.blue-green["ecs_blue_green_alb01"].arn
    }
    aws_lb_listner_2 = {
      target_group_arn = aws_lb_target_group.default["ecs_tg_05"].arn
      target_id        = aws_lb.blue-green["ecs_blue_green_alb02"].arn
    }
  }
}

#===================================
#===================================
#aws_ecs_service
locals {
  ecs_service_map_list = {
    ecs_fargate_service01 = {
      Name             = "ecs-fargate-service01"
      target_group_arn = aws_lb_target_group.default["ecs_tg_01"].arn
    }
    ecs_fargate_service02 = {
      Name             = "ecs-fargate-service02"
      target_group_arn = aws_lb_target_group.default["ecs_tg_02"].arn
    }
  }
}

locals {
  ecs_service_blue_green_map_list = {
    ecs_blue_green_service01 = {
      Name                    = "esvc-blue-green-01"
      first_target_group_arn  = aws_lb_target_group.default["ecs_tg_03"].arn
      second_target_group_arn = aws_lb_target_group.default["ecs_tg_04"].arn
    }
    ecs_blue_green_service02 = {
      Name                    = "esvc-blue-green-02"
      first_target_group_arn  = aws_lb_target_group.default["ecs_tg_05"].arn
      second_target_group_arn = aws_lb_target_group.default["ecs_tg_06"].arn
    }
  }
}