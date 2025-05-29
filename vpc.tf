resource "aws_vpc" "brinabh_vpc" {
  cidr_block       = "10.26.0.0/16"
  instance_tenancy = "default" # it's used shared hardware in backed and its cost effective

  tags = {
    Name = "brinabh"
  }
}