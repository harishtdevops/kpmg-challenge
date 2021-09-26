###############################################
# vpc
################################################
resource "aws_vpc" "kpmg-vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "kpmg-demo-vpc"
  }
}

################################################
# Subnets - Public
################################################
resource "aws_subnet" "kpmg-subnet-pub-az1" {
    vpc_id = "${aws_vpc.kpmg-vpc.id}"
    availability_zone = var.az1
    cidr_block = var.pub_subnet_cidr_az1
    tags = {
        Name = "kpmg-demo-subnet-pub-az1"
    }
}

resource "aws_subnet" "kpmg-subnet-pub-az2" {
    vpc_id = "${aws_vpc.kpmg-vpc.id}"
    availability_zone = var.az2
    cidr_block = var.pub_subnet_cidr_az2
    tags = {
        Name = "kpmg-demo-subnet-pub-az2"
    }
}

resource "aws_subnet" "kpmg-subnet-pub-az3" {
    vpc_id = "${aws_vpc.kpmg-vpc.id}"
    availability_zone = var.az3
    cidr_block = var.pub_subnet_cidr_az3
    tags = {
        Name = "kpmg-demo-subnet-pub-az3"
    }
}
################################################
# Subnet - Private
################################################
resource "aws_subnet" "kpmg-subnet-pvt-az1" {
    vpc_id = "${aws_vpc.kpmg-vpc.id}"
    availability_zone = var.az1
    cidr_block = var.pvt_subnet_cidr_az1
    tags = {
        Name = "kpmg-demo-subnet-pvt-az1"
    }
}
resource "aws_subnet" "kpmg-subnet-pvt-az2" {
    vpc_id = "${aws_vpc.kpmg-vpc.id}"
    availability_zone = var.az2
    cidr_block = var.pvt_subnet_cidr_az2
    tags = {
        Name = "kpmg-demo-subnet-pvt-az2"
    }
}
resource "aws_subnet" "kpmg-subnet-pvt-az3" {
    vpc_id = "${aws_vpc.kpmg-vpc.id}"
    availability_zone = var.az3
    cidr_block = var.pvt_subnet_cidr_az3
    tags = {
        Name = "kpmg-demo-subnet-pvt-az3"
    }
}

################################################
#internet gateway for public subnet
################################################
resource "aws_internet_gateway" "kpmg-igw" {
  vpc_id = "${aws_vpc.kpmg-vpc.id}"

  tags = {
    Name = "kpmg-demo-igw"
  }
}

resource "aws_route_table" "kpmg-rt-public" {
  vpc_id = "${aws_vpc.kpmg-vpc.id}"

  tags = {
    Name = "kpmg-demo-rt-public"
  }
}
resource "aws_route" "kpmg-rt-public_igw" {
  route_table_id = "${aws_route_table.kpmg-rt-public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.kpmg-igw.id}"
}
resource "aws_route_table_association" "kpmg-rt-public_igw-to-subnet_public_az1" {
  subnet_id      = "${aws_subnet.kpmg-subnet-pub-az1.id}"
  route_table_id = "${aws_route_table.kpmg-rt-public.id}"
}
resource "aws_route_table_association" "kpmg-rt-public_igw-to-subnet_public_az2" {
  subnet_id      = "${aws_subnet.kpmg-subnet-pub-az2.id}"
  route_table_id = "${aws_route_table.kpmg-rt-public.id}"
}
resource "aws_route_table_association" "kpmg-rt-public_igw-to-subnet_public_az3" {
  subnet_id      = "${aws_subnet.kpmg-subnet-pub-az3.id}"
  route_table_id = "${aws_route_table.kpmg-rt-public.id}"
}
################################################
# nat gateway for private subnet
################################################

resource "aws_eip" "nat_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.kpmg-igw]
    tags = {
    Name = "kpmg-demo-NAT"
  }
}
resource "aws_nat_gateway" "kpmg-ngw" {
  subnet_id = "${aws_subnet.kpmg-subnet-pub-az1.id}"
  allocation_id = "${aws_eip.nat_eip.id}"
  tags = {
    Name = "kpmg-demo-ngw"
  }
}
resource "aws_route_table" "kpmg-rt-ngw" {
  vpc_id = "${aws_vpc.kpmg-vpc.id}"

  tags = {
    Name = "kpmg-demo-rt-ngw"
  }
}
resource "aws_route" "kpmg-rt-pvt_ngw" {
  route_table_id = "${aws_route_table.kpmg-rt-ngw.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_nat_gateway.kpmg-ngw.id}"
}
resource "aws_route_table_association" "kpmg-rt_pvt_ngw-to-subnet_pvt_az1" {
  subnet_id      = "${aws_subnet.kpmg-subnet-pvt-az1.id}"
  route_table_id = "${aws_route_table.kpmg-rt-ngw.id}"
}
resource "aws_route_table_association" "kpmg-rt_pvt_ngw-to-subnet_pvt_az2" {
  subnet_id      = "${aws_subnet.kpmg-subnet-pvt-az2.id}"
  route_table_id = "${aws_route_table.kpmg-rt-ngw.id}"
}
resource "aws_route_table_association" "kpmg-rt_pvt_ngw-to-subnet_pvt_az3" {
  subnet_id      = "${aws_subnet.kpmg-subnet-pvt-az3.id}"
  route_table_id = "${aws_route_table.kpmg-rt-ngw.id}"
}
################################################
# security group
################################################

resource "aws_security_group" "kpmg-sg-pub" {
  name        = "kpmg-demo-sg-pub"
  description = "Rules for Public Subnet"
  vpc_id      = "${aws_vpc.kpmg-vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.kpmg-vpc.cidr_block}"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kpmg-demo-sg-public"
  }
}

resource "aws_security_group" "kpmg-sg-pvt" {
  name        = "kpmg-demo-sg-pvt"
  description = "Rules for Private subnet"
  vpc_id      = "${aws_vpc.kpmg-vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.kpmg-vpc.cidr_block}"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kpmg-demo-sg-pvt"
  }
}
