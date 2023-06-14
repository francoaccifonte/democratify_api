resource "aws_vpc" "rockolify" {
  cidr_block = var.cidrs.vpc

  tags = {
    Name = "rockolify"
  }
}

resource "aws_subnet" "rockolify-public" { // TODO: wrap this in a subnet group?
  vpc_id     = aws_vpc.rockolify.id
  cidr_block = var.cidrs.public_subnet

  tags = {
    Name = "rockolify-public"
  }
}

resource "aws_subnet" "rockolify-private" { // TODO: wrap this in a subnet group?
  vpc_id     = aws_vpc.rockolify.id
  cidr_block = var.cidrs.private_subnet

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
