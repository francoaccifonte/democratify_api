
resource "aws_security_group" "rockolify_public" {
  name        = "rockolify-public"
  description = "Allow internet traffic into public subnets"
  vpc_id      = aws_vpc.rockolify.id

  ingress {
    description = "attempt to allow ssh"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
    from_port   = 22
    to_port     = 22
  }

  tags = {
    Name = "rockolify-public"
  }
}

resource "aws_security_group" "rockolify_private" {
  name        = "from_public_to_private"
  description = "Allow traffic from public security group"
  vpc_id      = aws_vpc.rockolify.id

  tags = {
    Name = "rockolify-private"
  }

  ingress {
    protocol        = "tcp"
    security_groups = [aws_security_group.rockolify_public.id]
    cidr_blocks     = [var.cidrs.vpc]
    self            = true
    from_port       = 0
    to_port         = 10000
  }
}
