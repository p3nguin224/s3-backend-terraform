
# PUBLIC ROUTE TABLE CREATE
resource "aws_route_table" "dev-public-subnet-routeTable" {
  vpc_id = aws_vpc.dev-VCP-tokyo.id

  tags = {
    Name        = "dev-public-subnet-routeTable"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}

# Public Subnet Route 
resource "aws_route" "dev-public-subnet-routeTable-internetRoute" {
  route_table_id         = aws_route_table.dev-public-subnet-routeTable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev-IGW.id
}


## Public Route Table Association
resource "aws_route_table_association" "dev-public-subnetA-routeTable-Associate" {
  subnet_id      = aws_subnet.dev-public-subnet-A.id
  route_table_id = aws_route_table.dev-public-subnet-routeTable.id
}

resource "aws_route_table_association" "dev-public-subnetC-routeTable-Associate" {
  subnet_id      = aws_subnet.dev-public-subnet-C.id
  route_table_id = aws_route_table.dev-public-subnet-routeTable.id
}



# PRIVATE ROUTE TABLE CREATE
resource "aws_route_table" "dev-private-subnet-routeTable" {
  vpc_id = aws_vpc.dev-VCP-tokyo.id

  tags = {
    Name        = "dev-private-subnet-routeTable"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}

# Private Subnet Route 
resource "aws_route" "dev-private-subnet-routeTable-internetRoute" {
  route_table_id         = aws_route_table.dev-private-subnet-routeTable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.dev-NAT-GW.id
}


## Private Route Table Association
resource "aws_route_table_association" "dev-private-subnetA-routeTable-Associate" {
  subnet_id      = aws_subnet.dev-private-subnet-A.id
  route_table_id = aws_route_table.dev-private-subnet-routeTable.id
}
