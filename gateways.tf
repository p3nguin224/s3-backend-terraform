# EIP CREATE
resource "aws_eip" "dev-NAT-GW-EIP" {
  tags = {
    Name        = "dev-NAT-GW-EIP"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}

# GATEWAYS CREATE
resource "aws_internet_gateway" "dev-IGW" {
  vpc_id = aws_vpc.dev-VCP-tokyo.id

  tags = {
    Name        = "dev-IGW"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}


resource "aws_nat_gateway" "dev-NAT-GW" {
  allocation_id = aws_eip.dev-NAT-GW-EIP.allocation_id
  subnet_id     = aws_subnet.dev-public-subnet-C.id

  tags = {
    Name = "NAT GW ${var.evnironment_name}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.dev-IGW]
}
