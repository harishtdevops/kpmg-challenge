#Get the AMI ID of latest ubuntu 18.04
data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical
  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

resource "aws_instance" "kpmg-ec2" {
  #count         = var.ec2_count
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.kpmg-sg-pub.id]
  subnet_id = aws_subnet.kpmg-subnet-pub-az1.id
  key_name = var.ssh_key
  associate_public_ip_address = true

  root_block_device {
    volume_type  = "gp2"
    volume_size  = 50
    encrypted    = true
    delete_on_termination = true
  }
  volume_tags = {
    Terraform   = "true"
    Name = "kpmg-demo-web"
  }

  tags = {
    Name = "kpmg-demo-web"
    Terraform = "true"

  }
}