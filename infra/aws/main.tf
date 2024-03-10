provider "aws" {
 	region = var.aws_region
}

resource "random_id" "instance_id" {
  byte_length = 8
}

data "aws_ami" "ubuntu_2204" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "mykey" {
  key_name    = "mykey"
  public_key  = file(var.ssh_publickey)
}

resource "aws_security_group" "ollama_sg" {
  vpc_id = var.aws_vpcid

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "ollama" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = "g4dn.xlarge"
  vpc_security_group_ids = [aws_security_group.ollama_sg.id]
  key_name               = aws_key_pair.mykey.key_name
  subnet_id              = var.aws_subnet_a
  associate_public_ip_address = true

  tags = {
    Name                 = "ollama-${random_id.instance_id.hex}"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 60
    delete_on_termination = true
  }


}
