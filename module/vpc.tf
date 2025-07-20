resource "aws_vpc" "Sankari_VPC" {
cidr_block="10.0.0.0/16"
tags  = {
    name = "Sankari_VPC"
    }
}


resource "aws_subnet" "project17_subnet" {
  vpc_id            = aws_vpc.Sankari_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Sankari_Subnet"
}
}

resource "aws_security_group" "project17_sg" {
  name        = "Project17-Sankari-sg"
  description = "Main security group"
  vpc_id      = aws_vpc.Sankari_VPC.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 0
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Project17-Sankari-sg"
  }
}
