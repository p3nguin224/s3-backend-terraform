# BASTION HOST SECURITY GROUP CREATE
resource "aws_security_group" "dev-bastion-EC2-sg" {
  name        = "dev-bastion-EC2-sg"
  description = "Allow SSH from Home Network"
  vpc_id      = aws_vpc.dev-VCP-tokyo.id

  tags = {
    Name        = "dev-bastion-EC2-sg"
    Environment = "dev"
    Region      = "tokyo"
  }
}

# dev-bastion-EC2-sg rule
resource "aws_vpc_security_group_ingress_rule" "dev-bastion-EC2-sg-allow-ssh-myHomeIp" {
  security_group_id = aws_security_group.dev-bastion-EC2-sg.id
  cidr_ipv4         = var.ssh_open_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# dev-bastion-EC2-sg rule
resource "aws_vpc_security_group_egress_rule" "dev-bastion-EC2-sg-allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.dev-bastion-EC2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# PRIVATE HOST SECURITY GROUP CREATE
resource "aws_security_group" "dev-private-EC2-sg" {
  name        = "dev-private-EC2-sg"
  description = "Allow SSH from Home Network"
  vpc_id      = aws_vpc.dev-VCP-tokyo.id

  tags = {
    Name        = "dev-private-EC2-sg"
    Environment = "dev"
    Region      = "tokyo"
  }
}

# dev-private-EC2-sg rule
resource "aws_vpc_security_group_ingress_rule" "dev-private-EC2-sg-allow-ssh-to-LocalIP" {
  security_group_id = aws_security_group.dev-private-EC2-sg.id
  cidr_ipv4         = "10.0.0.0/16"
  ip_protocol       = -1

}

# dev-private-EC2-sg rule
resource "aws_vpc_security_group_egress_rule" "dev-private-EC2-sg-allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.dev-private-EC2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
