resource "aws_db_parameter_group" "aurora-postgres12" {
  name   = "aurora-postgres-blue-green-pg"
  family = "aurora-postgresql12"
  description = "aurora blue green parameter group"
}

resource "aws_rds_cluster_parameter_group" "aurora-postgres12" {
  name = "aurora-cluster-postgres-blue-green-pg"
  family = "aurora-postgresql12"

  parameter {
    name         = "rds.logical_replication"
    value        = "1"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_parameter_group" "aurora-postgres16" {
  name   = "aurora-postgres-blue-green-pg-16"
  family = "aurora-postgresql16"
  description = "aurora blue green parameter group"
}

resource "aws_rds_cluster_parameter_group" "aurora-postgres16" {
  name = "aurora-cluster-postgres-blue-green-pg-16"
  family = "aurora-postgresql16"
}