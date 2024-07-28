
resource "aws_nat_gateway" "main" {
  for_each = local.natgateway_map_list
  allocation_id = data.aws_eip.by_tags[each.value.eip_name].id
  subnet_id     = each.value.subnet_id

  tags = {
    Name = each.value.Name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw, aws_eip.main]
}

