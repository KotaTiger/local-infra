
#===================================
#===================================
#elastic ip

data "aws_eip" "by_tags" {
  for_each = local.elastic_ip_map_list
  tags = {
    Name = each.value.Name
  }
  depends_on = [aws_eip.main]
}

#===================================
#===================================
#ecr

data "aws_ecr_repository" "flask-demo-app" {
  name = "flask-demo-app"
}
