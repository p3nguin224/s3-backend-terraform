output "dev_network_id" {
  value = {
    "vpc_id"              = aws_vpc.dev-VCP-tokyo.id,
    "public_subnet_A_id"  = aws_subnet.dev-public-subnet-A.id,
    "public_subnet_C_id"  = aws_subnet.dev-public-subnet-C.id,
    "private_subnet_A_id" = aws_subnet.dev-private-subnet-A.id,
  }

}
