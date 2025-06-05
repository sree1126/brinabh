resource "aws_route_table" "brinabh-public_rt" {
  vpc_id = aws_vpc.brinabh_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "brinabh_public_rt"
  }
}

resource "aws_route_table" "brinabh-private_rt" {
  vpc_id = aws_vpc.brinabh_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.brinabh_public_nat.id
  }

  tags = {
    Name = "brinabh_private_rt"
  }
}


resource "aws_route_table_association" "brinabh-private-rt-us-east-1a" {
  subnet_id      = aws_subnet.brinabh_private_subnet_east-1a.id
  route_table_id = aws_route_table.brinabh-private_rt.id
}

resource "aws_route_table_association" "brinabh-public-rt-us-east-1a" {
  subnet_id      = aws_subnet.brinabh_public_subnet_east-1a.id
  route_table_id = aws_route_table.brinabh-public_rt.id
}

resource "aws_route_table_association" "brinabh-private-rt-us-east-1b" {
  subnet_id      = aws_subnet.brinabh_private_subnet_east-1b.id
  route_table_id = aws_route_table.brinabh-private_rt.id
}

resource "aws_route_table_association" "brinabh-public-rt-us-east-1b" {
  subnet_id      = aws_subnet.brinabh_public_subnet_east-1b.id
  route_table_id = aws_route_table.brinabh-public_rt.id
}