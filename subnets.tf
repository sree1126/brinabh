resource "aws_subnet" "brinabh_public_subnet" {
  vpc_id     = aws_vpc.brinabh_vpc.id
  cidr_block = "10.26.1.0/24"

  tags = {
    Name = "brinabh_public_subnet"
  }
}

resource "aws_subnet" "brinabh_private_subnet" {
  vpc_id     = aws_vpc.brinabh_vpc.id
  cidr_block = "10.26.2.0/24"

  tags = {
    Name = "brinabh_private_subnet"
  }
}