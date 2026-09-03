# Create bastion host in Public Subnet
resource "aws_instance" "dev-bastion-EC2" {
  ami                         = "ami-0794a632d5c1058bf"
  instance_type               = var.ec2_instance_type
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
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}


# Create server in Private Subnet
resource "aws_instance" "dev-private-EC2" {
  ami                         = "ami-0794a632d5c1058bf"
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.dev-ec2-keypair.key_name
  subnet_id                   = aws_subnet.dev-private-subnet-A.id
  associate_public_ip_address = false

  vpc_security_group_ids = [aws_security_group.dev-private-EC2-sg.id]
  tags = {
    Name        = "dev-private-EC2"
    Environment = var.evnironment_name
    Region      = "tokyo"
  }
}



