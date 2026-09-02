# Create private Key
resource "tls_private_key" "dev-local-ec2-priv-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Store the contents as file on local
resource "local_file" "foo" {
  content  = tls_private_key.dev-local-ec2-priv-key.private_key_openssh
  filename = "${path.module}/keys/${var.aws_ec2_keypairname}.pem"

  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/keys/${var.aws_ec2_keypairname}.pem"
  }
}


resource "aws_key_pair" "dev-ec2-keypair" {
  key_name   = var.aws_ec2_keypairname
  public_key = tls_private_key.dev-local-ec2-priv-key.public_key_openssh
  tags = {
    Name        = var.aws_ec2_keypairname
    Environment = "dev"
    Region      = "tokyo"
  }
}
