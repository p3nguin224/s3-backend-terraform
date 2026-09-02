# VPC CREATE
resource "aws_vpc" "dev-VCP-tokyo" {
  cidr_block = "10.0.0.0/16"
  region     = "ap-northeast-1"

  tags = {
    Name        = "dev-VCP-tokyo"
    Environment = "dev"
    Region      = "tokyo"
  }
}

# SUBNET CREATE
resource "aws_subnet" "dev-public-subnet-A" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "dev-public-subnet-A"
    Environment = "dev"
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-public-subnet-C" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name        = "dev-public-subnet-C"
    Environment = "dev"
    Region      = "tokyo"
  }
}

resource "aws_subnet" "dev-private-subnet-A" {
  vpc_id            = aws_vpc.dev-VCP-tokyo.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name        = "dev-private-subnet-A"
    Environment = "dev"
    Region      = "tokyo"
  }
}

# EIP CREATE
resource "aws_eip" "dev-NAT-GW-EIP" {
  tags = {
    Name        = "dev-NAT-GW-EIP"
    Environment = "dev"
    Region      = "tokyo"
  }
}

# GATEWAYS CREATE
resource "aws_internet_gateway" "dev-IGW" {
  vpc_id = aws_vpc.dev-VCP-tokyo.id

  tags = {
    Name        = "dev-IGW"
    Environment = "dev"
    Region      = "tokyo"
  }
}


resource "aws_nat_gateway" "dev-NAT-GW" {
  allocation_id = aws_eip.dev-NAT-GW-EIP.allocation_id
  subnet_id     = aws_subnet.dev-public-subnet-C.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.dev-IGW]
}


# ROUTE TABLE CREATE
# resource "aws_route_table" "dev-public-subnet-routeTable" {
#   vpc_id = aws_vpc.dev-VCP-tokyo

#   route {
#     cidr_block           = "0.0.0.0/0"
#     network_interface_id = aws_network_interface.test.id
#   }
#   tags = {
#     Name        = "dev-public-subnet-routeTable"
#     Environment = "dev"
#     Region      = "tokyo"
#   }
# }


# data "aws_route_tables" "dev-private-subnet-routeTable" {
#   vpc_id = aws_vpc.dev-VCP-tokyo

#   tags = {
#     Name        = "dev-private-subnet-routeTable"
#     Environment = "dev"
#     Region      = "tokyo"
#   }
# }
