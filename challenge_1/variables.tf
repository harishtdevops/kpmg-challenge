variable "access_key" {
  default = ""
} 
variable "secret_key" {
  default = ""
} 

variable "az1" {
  description = "The Avaliability Zone where the resources gets created"
  default = "us-east-1c"
}
variable "az2" {
  description = "The Avaliability Zone where the resources gets created"
  default = "us-east-1a"
}
variable "az3" {
  description = "The Avaliability Zone where the resources gets created"
  default = "us-east-1b"
}

variable "def_region" {
  description = "The Region where the entire infrastructure will be created"
  default = "us-east-1"
}

variable "env" {
  description = "Specifies the name of the Environment"
  default = "kpmg-demo"
}

variable "vpc_cidr_block" {
  description = "IP Range to be used for the CIDR block under VPC"
  default = "172.31.0.0/16"
}
variable "pub_subnet_cidr_az1" {
  description = "IP Range of the subnet to be created"
  default = "172.31.1.0/24"
}
variable "pub_subnet_cidr_az2" {
  description = "IP Range of the subnet to be created"
  default = "172.31.2.0/24"
}
variable "pub_subnet_cidr_az3" {
  description = "IP Range of the subnet to be created"
  default = "172.31.3.0/24"
}
variable "pvt_subnet_cidr_az1" {
  description = "IP Range of the subnet to be created"
  default = "172.31.4.0/24"
}
variable "pvt_subnet_cidr_az2" {
  description = "IP Range of the subnet to be created"
  default = "172.31.5.0/24"
}
variable "pvt_subnet_cidr_az3" {
  description = "IP Range of the subnet to be created"
  default = "172.31.6.0/24"
}

variable "ec2_instance_type" {
  default = "t3.medium"
}
variable "ssh_key" {
  default = "kpmg-demo-ssh-key"
}

variable "ec2_count" {
  description = "Number of EC2 instances to be created"
  default = 2
}

variable "subnet_grp_name" {
  default = "dbsg-kpmg-pvt"
}

variable "db_engine_version" {
  default = "11.8"
}
variable "db_instance_class" {
  default = "db.r5.large"
}

variable "db_name" {
  default = "postgres"
}
variable "db_username" {
  default = "postgres"
}
variable "db_password" {
  default = "AwZio7mG!$I"
}
variable "engine" {
  default = "aurora-postgresql"
}
variable "db_port" {
  default = "5432"
}

variable "kms_arn_id" {
  default = "arn:aws:kms:us-east-1:123456789:key/9b17b61f-7fbb-446e-82cb-cb2cfab330a6"
}
variable "no_of_db_instances" {
  default = 1
}