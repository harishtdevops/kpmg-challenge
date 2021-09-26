################################################
#Create RDS
################################################

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.kpmg-subnet-pvt-az1.id, aws_subnet.kpmg-subnet-pvt-az2.id, aws_subnet.kpmg-subnet-pvt-az3.id]

  tags = {
    Name = "rds-db-pvt-subnet-grp"
  }
}

resource "aws_rds_cluster_instance" "edf-rds_cluster_instances" {
  count                      = "${var.no_of_db_instances}"
  identifier                 =  var.env
  cluster_identifier         = "${aws_rds_cluster.edf-rds_cluster.id}"
  instance_class             = "${var.db_instance_class}"
  engine                     = "${aws_rds_cluster.edf-rds_cluster.engine}"
  engine_version             = "${aws_rds_cluster.edf-rds_cluster.engine_version}"
  auto_minor_version_upgrade = true
  #multi_az                   = false
  publicly_accessible        = false

}
resource "aws_rds_cluster" "edf-rds_cluster" {
  cluster_identifier         = var.env
  engine                     = "${var.engine}"
  engine_version             = "${var.db_engine_version}"
  port                       = "${var.db_port}"
  #database_name              = "${var.db_name}"
  master_username            = "${var.db_username}"
  master_password            = "${var.db_password}"
  backup_retention_period    = 7
  #preferred_backup_window    = "07:00-09:00"
  deletion_protection        = false
  db_subnet_group_name       = "${aws_db_subnet_group.default.id}"
  vpc_security_group_ids     = [aws_security_group.kpmg-sg-pub.id]
  #kms_key_id                 = "${var.kms_arn_id}"
  skip_final_snapshot        = true
  storage_encrypted          = true
  #allocated_storage          = 256 # gigabytes
  tags = {
    Name = var.env
  }
}