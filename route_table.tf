resource "aws_route_table" "public" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-public"
  }

  tags_all = {
    Name = "rt-public"
  }

  vpc_id = aws_vpc.main.id
}


resource "aws_route_table" "private" {
  for_each = local.route_table_map_list

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.natgw_id
  }

  tags = {
    Name = each.value.Name
  }

  tags_all = {
    Name = each.value.Name
  }

  vpc_id = aws_vpc.main.id
}
