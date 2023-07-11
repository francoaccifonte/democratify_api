resource "aws_vpc" "rockolify" {
  cidr_block           = var.cidrs.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "rockolify"
  }
}

resource "aws_subnet" "rockolify_public" { // TODO: wrap this in a subnet group?
  vpc_id                  = aws_vpc.rockolify.id
  cidr_block              = var.cidrs.public_subnet
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "rockolify-public"
  }
}

resource "aws_subnet" "rockolify_public2" { // TODO: wrap this in a subnet group?
  vpc_id                  = aws_vpc.rockolify.id
  cidr_block              = var.cidrs.public_subnet2
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "rockolify-public2"
  }
}

resource "aws_subnet" "rockolify_private" { // TODO: wrap this in a subnet group?
  vpc_id                  = aws_vpc.rockolify.id
  cidr_block              = var.cidrs.private_subnet
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = false

  tags = {
    Name = "rockolify-private"
  }
}

resource "aws_subnet" "rockolify_private2" { // TODO: wrap this in a subnet group?
  vpc_id                  = aws_vpc.rockolify.id
  cidr_block              = var.cidrs.private_subnet2
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "rockolify-private"
  }
}

resource "aws_internet_gateway" "rockolify" {
  vpc_id = aws_vpc.rockolify.id

  tags = {
    Name = "rockolify-igw"
  }
}

resource "aws_route_table" "rockolify_public_route_table" {
  vpc_id = aws_vpc.rockolify.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rockolify.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.rockolify_public.id
  route_table_id = aws_route_table.rockolify_public_route_table.id
}
