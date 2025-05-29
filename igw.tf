resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.brinabh_vpc.id

  tags = {
    Name = "brinabh_igw"
  }
}