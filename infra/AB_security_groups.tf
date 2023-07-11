
resource "aws_security_group" "rockolify_public" {
  name        = "rockolify-public"
  description = "Allow internet traffic into public subnets"
  vpc_id      = aws_vpc.rockolify.id

  ingress {
    description = "allow ssh into ec2 instance"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
    from_port   = 22
    to_port     = 22
  }

  ingress {
    description = "rails app inbound traffic from https"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
    from_port   = 443
    to_port     = 443
  }

  ingress {
    description = "rails app inbound traffic from http"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
    from_port   = 80
    to_port     = 80
  }

  egress {
    description = "Allow all outgoing traffic"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
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
