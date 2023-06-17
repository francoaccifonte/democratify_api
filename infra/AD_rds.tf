resource "aws_db_subnet_group" "rockolify_db_subnet_group" {
  name       = "rockolify_db_subnet_group"
  subnet_ids = [aws_subnet.rockolify_private.id, aws_subnet.rockolify_private2.id]

  tags = {
    Name = "Subnet for the rockolify db"
  }
}

resource "aws_db_instance" "rockolify_db" {
  allocated_storage = 10
  engine            = "postgres"
  engine_version    = "15.3"
  instance_class    = "db.t3.micro"
  db_name           = "Rockolify"
  username          = var.db_username
  password          = var.db_password
  # parameter_group_name = "default.mysql5.7"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rockolify_private.id]
  db_subnet_group_name   = aws_db_subnet_group.rockolify_db_subnet_group.name
  multi_az               = false
}