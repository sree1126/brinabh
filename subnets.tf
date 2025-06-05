# public subnet 01
resource "aws_subnet" "brinabh_public_subnet_east-1a" {
  vpc_id     = aws_vpc.brinabh_vpc.id
  cidr_block = "10.26.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "brinabh_public_subnet_east-1a"
    "kubernetes.io/role/elb"     = "1" #this instruct the kubernetes to create public load balancer in these subnet
    "kubernetes.io/cluster/brinabh"   = "owned"
  }
}

# private subnet 01
resource "aws_subnet" "brinabh_private_subnet_east-1a" {
  vpc_id     = aws_vpc.brinabh_vpc.id
  cidr_block = "10.26.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "brinabh_private_subnet_east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/brinabh"   = "owned"
  }
}

# public subnet 02
resource "aws_subnet" "brinabh_public_subnet_east-1b" {
  vpc_id     = aws_vpc.brinabh_vpc.id
  cidr_block = "10.26.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "brinabh_public_subnet_east-1b"
    "kubernetes.io/role/elb"     = "1" #this instruct the kubernetes to create public load balancer in these subnet
    "kubernetes.io/cluster/brinabh"   = "owned"
  }
}

# private subnet 02
resource "aws_subnet" "brinabh_private_subnet_east-1b" {
  vpc_id     = aws_vpc.brinabh_vpc.id
  cidr_block = "10.26.4.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name = "brinabh_private_subnet_east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/brinabh"   = "owned"
  }
}