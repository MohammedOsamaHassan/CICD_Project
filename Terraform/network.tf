# My Terraform Network 
# VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

# Subnets
resource "aws_subnet" "mysubnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = var.igw_name
  }
}

# Route Table
resource "aws_route_table" "myroute_table" {
  vpc_id =  aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = var.route_table_name
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "myroute_table_association" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myroute_table.id
  
}