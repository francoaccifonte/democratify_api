
resource "aws_security_group" "rockolify_public" {
  name        = "rockolify-public"
  description = "Allow internet traffic into public subnets"
  vpc_id      = aws_vpc.rockolify.id

  tags = {
    Name = "rockolify-public"
  }
}

resource "aws_security_group" "rockolify_private" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.rockolify.id

  tags = {
    Name = "rockolify-private"
  }

  ingress {
    protocol = "tcp"
    security_groups = [aws_security_group.rockolify_public.id]
    cidr_blocks = [var.cidrs.vpc]
    self            = true
    from_port = 0
    to_port = 10000
  }
}
