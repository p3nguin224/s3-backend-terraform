output "dev_network_id" {
  value = {
    "vpc_id"              = aws_vpc.dev-VCP-tokyo.id,
    "public_subnet_A_id"  = aws_subnet.dev-public-subnet-A.id,
    "public_subnet_C_id"  = aws_subnet.dev-public-subnet-C.id,
    "private_subnet_A_id" = aws_subnet.dev-private-subnet-A.id,
    "EIP_address"         = aws_eip.dev-NAT-GW-EIP.public_ip,
    "IGW_id"              = aws_internet_gateway.dev-IGW.id,
    "NAT_GW_id"           = aws_eip.dev-NAT-GW-EIP.id,
    "Public Route Table"  = aws_route_table.dev-public-subnet-routeTable.route,
    "Private Route Table" = aws_route_table.dev-private-subnet-routeTable.route
  }

}

output "EC2-Values" {
  value = {
    "Bastion Host Public IP"    = aws_instance.dev-bastion-EC2.public_ip,
    "Bastion Host Private IP"   = aws_instance.dev-bastion-EC2.private_ip,
    "Private Server Private IP" = aws_instance.dev-private-EC2.private_ip
  }
}
