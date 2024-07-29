/*
resource "aws_rds_cluster" "default" {
  cluster_identifier = "example-cluster"
  engine = "aurora-postgresql"
  engine_version = "12.16"
  master_username = var.db_username
  master_password = var.db_password
  port = 5432
  database_name = "bluegreendeploy"
  db_subnet_group_name = aws_db_subnet_group.default.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora-postgres12.name
  vpc_security_group_ids = [aws_security_group.aurora-postgres-sg.id]
  iam_database_authentication_enabled = true

  skip_final_snapshot = true
  apply_immediately = true
}
*/