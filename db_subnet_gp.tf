resource "aws_db_subnet_group" "default" {
  name       = "aurora-postgres-blue-green-subnet-gp"
  subnet_ids = [aws_subnet.main["public-1a"].id, aws_subnet.main["public-1c"].id]
}