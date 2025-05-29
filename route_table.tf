resource "aws_route_table" "brinabh_public_rt" {
  vpc_id = aws_vpc.brinabh_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "brinabh_public_rt"
  }
}

resource "aws_route_table" "brinabh_private_rt" {
  vpc_id = aws_vpc.brinabh_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.brinabh_public_nat.id
  }

  tags = {
    Name = "brinabh_private_rt"
  }
}
