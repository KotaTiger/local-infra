/*
resource "aws_rds_cluster_instance" "default" {
  count = 2

  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "example-cluster-instance-${count.index}"

  engine                  = aws_rds_cluster.default.engine
  engine_version          = aws_rds_cluster.default.engine_version

  #instance sizeがt3.medium(課金対象)である点に十分注意
  instance_class          = "db.t3.medium"
  
  db_subnet_group_name    = aws_db_subnet_group.default.name
  db_parameter_group_name = aws_db_parameter_group.aurora-postgres12.name
  publicly_accessible = true
}
*/