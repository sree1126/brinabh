resource "aws_eip" "brinabh_public_nat_eip" {

  tags = {
    Name = "brinabh_public_nat_eip"
  }
}