resource "aws_vpc" "rockolify" {
  cidr_block = var.cidrs.vpc

  tags = {
    Name = "rockolify"
  }
}

resource "aws_subnet" "rockolify_public" { // TODO: wrap this in a subnet group?
  vpc_id            = aws_vpc.rockolify.id
  cidr_block        = var.cidrs.public_subnet
  availability_zone = "us-east-2b"

  tags = {
    Name = "rockolify-public"
  }
}

resource "aws_subnet" "rockolify_private" { // TODO: wrap this in a subnet group?
  vpc_id            = aws_vpc.rockolify.id
  cidr_block        = var.cidrs.private_subnet
  availability_zone = "us-east-2b"

  tags = {
    Name = "rockolify-private"
  }
}

resource "aws_subnet" "rockolify_private2" { // TODO: wrap this in a subnet group?
  vpc_id            = aws_vpc.rockolify.id
  cidr_block        = var.cidrs.private_subnet2
  availability_zone = "us-east-2a"

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
