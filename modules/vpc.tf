
variable "vpc_name" {
  type    = string
  default = "SankariEx_VPC"
}

data "aws_vpcs" "by_name" { //check existing VPCs by name
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

resource "aws_vpc" "this_vpc" {
  count = length(data.aws_vpcs.by_name.ids) == 0 ? 1 : 0
  cidr_block="10.0.0.0/16"
  tags  = {
    Name = var.vpc_name
    }
}


resource "aws_subnet" "this_subnet" {
  count = length(data.aws_vpcs.by_name.ids) == 0 ? 1 : 0
  vpc_id            = aws_vpc.this_vpc[0].id  
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "SankariEx_Subnet"
}
}

resource "aws_security_group" "this_sg" {
   count = length(data.aws_vpcs.by_name.ids) == 0 ? 1 : 0
  name        = "SankariEx-sg"
  description = "Main security group"
  vpc_id      = aws_vpc.this_vpc[0].id

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
