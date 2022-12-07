# terraform {
#   backend "s3" {
#     # rename to match whats defined in the backend
#     bucket         = "root-tf-state-demo"
#     key            = "sandbox/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-state-locks"
#   }
# }

# Use the templated instances module
# module "instances" {
#   source = "../modules/templated_instances"
#   names  = ["demo1", "demo2"]
#   template = {
#     ami           = "ami-006c19cfa0e8f4672"
#     instance_type = "t4g.small"
#   }
# }

# Create a VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "demo-vpc"
  }
}

# Create subnet in each availability zone
resource "aws_subnet" "demo-subnet-a" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "demo-subnet-a"
  }
}

resource "aws_subnet" "demo-subnet-b" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "demo-subnet-b"
  }
}

resource "aws_subnet" "demo-subnet-c" {
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "172.16.30.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    Name = "demo-subnet-c"
  }
}

# Create a security group in the VPC
resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Demo"
  vpc_id      = aws_vpc.demo-vpc.id

  # ingress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-sg"
  }
}

resource "aws_instance" "demo-instance-1" {
  ami                    = "ami-006c19cfa0e8f4672"
  instance_type          = "t4g.small"
  subnet_id              = aws_subnet.demo-subnet-a.id
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    "Name" = "demo-instance-1"
  }
}

resource "aws_instance" "demo-instance-2" {
  ami                    = "ami-006c19cfa0e8f4672"
  instance_type          = "t4g.small"
  subnet_id              = aws_subnet.demo-subnet-b.id
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    "Name" = "demo-instance-2"
  }
}

resource "aws_instance" "demo-instance-3" {
  ami                    = "ami-006c19cfa0e8f4672"
  instance_type          = "t4g.small"
  subnet_id              = aws_subnet.demo-subnet-c.id
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    "Name" = "demo-instance-3"
  }
}

