resource "aws_nat_gateway" "brinabh_public_nat" {
  allocation_id = aws_eip.brinabh_public_nat_eip.id
  subnet_id     = aws_subnet.brinabh_public_subnet_east-1a.id

  tags = {
    Name = "brinabh_public_nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}