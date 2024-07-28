resource "aws_subnet" "main" {
  for_each = local.subnet_map_list

  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  tags = {
    Name = each.value.name
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table_association" "public" {
  for_each = local.route_table_association_map_list
  subnet_id     = each.value.subnet_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = local.private_route_table_association_map_list
  subnet_id     = each.value.subnet_id
  route_table_id = each.value.route_table_id
}
