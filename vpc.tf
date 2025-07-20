resource "aws_vpc" "Sankari_VPC" {
cidr_block="10.0.0.0/16"
tags  = {
    name = "Sankari_VPC"
    }
}

resource "aws_subnet" "Sankari_Subnet" {
  vpc_id            = aws_vpc.Sankari_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Sankari_Subnet"
}