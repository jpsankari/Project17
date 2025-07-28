resource "aws_vpc" "this_vpc" {
cidr_block="10.0.0.0/16"
tags  = {
    name = "Sankari_VPC"
    }
}


resource "aws_subnet" "this_subnet" {
  vpc_id            = aws_vpc.Sankari_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Sankari_Subnet"
}
}

resource "aws_security_group" "this_sg" {
  name        = "SankariEx-sg"
  description = "Main security group"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 0
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "SankariEx-SG"
  }
}
