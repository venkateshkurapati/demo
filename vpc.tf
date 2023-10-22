[4:33 PM] Silvester Rajpaul

main.tf

 

provider "aws" {

  region = var.aws_region

}

 

resource "aws_db_instance" "default" {

  depends_on             = [aws_security_group.default]

  identifier             = var.identifier

  allocated_storage      = var.storage

  engine                 = var.engine

  engine_version         = var.engine_version[var.engine]

  instance_class         = var.instance_class

  name                   = var.db_name

  username               = var.username

  password               = var.password

  vpc_security_group_ids = [aws_security_group.default.id]

  db_subnet_group_name   = aws_db_subnet_group.default.id

}

 

resource "aws_db_subnet_group" "default" {

  name        = "main_subnet_group"

  description = "Our main group of subnets"

  subnet_ids  = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

}

 

resource "aws_subnet" "subnet_1" {

  vpc_id            = var.vpc_id

  cidr_block        = var.subnet_1_cidr

  availability_zone = var.az_1

 

  tags = {

    Name = "main_subnet1"

Company Name = "Outsystem"

  }

}

 

resource "aws_subnet" "subnet_2" {

  vpc_id            = var.vpc_id

  cidr_block        = var.subnet_2_cidr

  availability_zone = var.az_2

 

  tags = {

    Name = "main_subnet2"

  }

}

 

resource "aws_security_group" "default" {

  name        = "main_rds_sg"

  description = "Allow all inbound traffic"

  vpc_id      = var.vpc_id

 

  ingress {

    from_port   = 0

    to_port     = 65535

    protocol    = "TCP"

    cidr_blocks = [var.cidr_blocks]

  }

 

  egress {

    from_port   = 0

    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

 

  tags = {

    Name = var.sg_name

  }

}

 

 



---

variable.tf

 

variable "cidr_blocks" {

  default     = "0.0.0.0/0"

  description = "CIDR for sg"

}

 

variable "sg_name" {

  default     = "rds_sg"

  description = "Tag Name for sg"

}

 

variable "subnet_1_cidr" {

  default     = "10.0.1.0/24"

  description = "Your AZ"

}

 

variable "subnet_2_cidr" {

  default     = "10.0.2.0/24"

  description = "Your AZ"

}

 

variable "az_1" {

  default     = "us-east-1b"

  description = "Your Az1, use AWS CLI to find your account specific"

}

 

variable "az_2" {

  default     = "us-east-1c"

  description = "Your Az2, use AWS CLI to find your account specific"

}

 

variable "vpc_id" {

  description = "Your VPC ID"

}

 



variable "aws_region" {

  default = "us-west-2"

}

 

variable "identifier" {

  default     = "mydb-rds"

  description = "Identifier for your DB"

}

 

variable "storage" {

  default     = "10"

  description = "Storage size in GB"

}

 

variable "engine" {

  default     = "postgres"

  description = "Engine type, example values mysql, postgres"

}

 

variable "engine_version" {

  description = "Engine version"

 

  default = {

    mysql    = "5.7.21"

    postgres = "9.6.8"

  }

}

 

variable "instance_class" {

  default     = "db.t2.micro"

  description = "Instance class"

}

 

variable "db_name" {

  default     = "mydb"

  description = "db name"

}

 

variable "username" {

  default     = "myuser"

  description = "User name"

}

 

variable "password" {

  description = "password, provide through your ENV variables"

}