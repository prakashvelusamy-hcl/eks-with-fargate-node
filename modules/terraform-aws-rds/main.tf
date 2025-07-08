
#########################
# RDS Instance
#########################
resource "aws_db_instance" "default" {
  identifier             = "my-rds-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  username               = "admin"
  password               = random_password.db_password.result
  db_name                = "employees"
  skip_final_snapshot    = true
  publicly_accessible    = false
  apply_immediately      = true
  multi_az               = false

  tags = {
    Name = "rds-instance"
  }
}

# resource "random_password" "db_password" {
#   length  = 16
#   special = true
# }

# resource "aws_secretsmanager_secret" "rds_credentials" {
#   name = "aurora-db-credentials"
# }

# resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
#   secret_id = aws_secretsmanager_secret.rds_credentials.id

#   secret_string = jsonencode({
#     username = var.db_username
#     password = random_password.db_password.result
#   })
# }

# resource "aws_rds_cluster" "aurora_mysql" {
#   cluster_identifier         = "aurora-mysql-cluster"
#   engine                     = "aurora-mysql"
#   engine_version             = "8.0.mysql_aurora.3.04.0"
#   database_name              = var.database_name
#   master_username            = var.db_username
#   master_password            = random_password.db_password.result
#   manage_master_user_password = false

#   db_subnet_group_name       = aws_db_subnet_group.subnet_group.name
#   vpc_security_group_ids     = var.rds_security_group_ids
#   skip_final_snapshot        = true
# }



resource "aws_db_subnet_group" "subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = var.private_subnets
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_rds_cluster" "aurora_mysql" {
  cluster_identifier = "aurora-mysql-cluster"
  engine             = "aurora-mysql"
  engine_version     = "8.0.mysql_aurora.3.04.0"
  database_name      = var.database_name

  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = var.rds_security_group_ids

  manage_master_user_password = true
  master_username             = var.db_username
  skip_final_snapshot         = true
}



resource "aws_rds_cluster_instance" "aurora_instances" {
  count                = 1
  identifier           = "aurora-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.aurora_mysql.id
  instance_class       = "db.t3.medium"
  engine               = aws_rds_cluster.aurora_mysql.engine
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  publicly_accessible  = false

}

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_mysql.endpoint
}

#output "aurora_cluster_instance_endpoint" {
#  value = aws_rds_cluster.aurora_instances.endpoint
#}