
resource "aws_eip" "main" {
  for_each = local.elastic_ip_map_list
  domain   = "vpc"

  tags = {
    Name = each.value.Name
  }
}
