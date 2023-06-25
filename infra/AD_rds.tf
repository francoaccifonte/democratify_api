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
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rockolify_private.id]
  db_subnet_group_name   = aws_db_subnet_group.rockolify_db_subnet_group.name
  multi_az               = false
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/rockolify/database/password"
  description = "DB Password"
  type        = "SecureString"
  value       = aws_db_instance.rockolify_db.password
  overwrite = true
}

resource "aws_ssm_parameter" "db_name" {
  name        = "/rockolify/database/name"
  description = "DB Name"
  type        = "SecureString"
  value       = aws_db_instance.rockolify_db.db_name
  overwrite = true
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/rockolify/database/username"
  description = "DB Name"
  type        = "SecureString"
  value       = aws_db_instance.rockolify_db.username
  overwrite = true
}

resource "aws_ssm_parameter" "db_url" {
  name        = "/rockolify/database/url"
  description = "host url"
  type        = "String"
  value       = aws_db_instance.rockolify_db.address
  overwrite = true
}

resource "aws_ssm_parameter" "db_port" {
  name        = "/rockolify/database/port"
  description = "host url"
  type        = "String"
  value       = aws_db_instance.rockolify_db.port
  overwrite = true
}
