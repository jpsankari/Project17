
data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = "Sankari_VPC"
  }
}

resource "aws_vpc" "this_vpc" {
count = length(data.aws_vpcs.by_name.ids) == 0 ? 1 : 0

cidr_block="10.0.0.0/16"
tags  = {
    name = "SankariEx_VPC"
    }
}


resource "aws_subnet" "this_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "SankariEx_Subnet"
}
}

resource "aws_security_group" "this_sg" {
  name        = "SankariEx-sg"
  description = "Main security group"
  vpc_id      = aws_vpc.this_vpc.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 0
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "SankariEx_security_group"
  }
}
