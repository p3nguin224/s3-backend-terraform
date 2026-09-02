# Create bastion host in Public Subnet
resource "aws_instance" "dev-bastion-EC2" {
  ami                         = "ami-0794a632d5c1058bf"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.dev-ec2-keypair.key_name
  subnet_id                   = aws_subnet.dev-public-subnet-A.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.dev-bastion-EC2-sg.id]

  provisioner "file" {
    content     = tls_private_key.dev-local-ec2-priv-key.private_key_openssh
    destination = "/home/ec2-user/.ssh/${var.aws_ec2_keypairname}.pem"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.dev-local-ec2-priv-key.private_key_openssh
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = ["chmod 400 /home/ec2-user/.ssh/${var.aws_ec2_keypairname}.pem"]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.dev-local-ec2-priv-key.private_key_openssh
      host        = self.public_ip
    }
  }

  tags = {
    Name        = "dev-bastion-EC2"
    Environment = "dev"
    Region      = "tokyo"
  }
}


# Create server in Private Subnet
resource "aws_instance" "dev-private-EC2" {
  ami                         = "ami-0794a632d5c1058bf"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.dev-ec2-keypair.key_name
  subnet_id                   = aws_subnet.dev-private-subnet-A.id
  associate_public_ip_address = false

  #   user_data_replace_on_change = false
  #   user_data                   = <<-EOF
  #                 #!/bin/bash
  #                 mkdir -p /home/ec2-user/.ssh
  #                 echo "${base64encode(tls_private_key.dev-local-ec2-priv-key.private_key_openssh)}"| base64 -d > /home/ec2-user/.ssh/${var.aws_ec2_keypairname}.pem
  #                 chmod 400 /home/ec2-user/.ssh/${var.aws_ec2_keypairname}.pem
  #                 chown -R ec2-user:ec2-user /home/ec2-user/.ssh
  #                 EOF
  vpc_security_group_ids = [aws_security_group.dev-private-EC2-sg.id]
  tags = {
    Name        = "dev-private-EC2"
    Environment = "dev"
    Region      = "tokyo"
  }
}


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
