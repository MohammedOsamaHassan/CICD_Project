variable "vpc_name" {
  type        = string
  description = "Name for the VPC"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "subnet_name" {
  type        = string
  description = "Name for the public subnet"
}

variable "igw_name" {
  type        = string
  description = "Name for the Internet Gateway"
  
}

variable "route_table_name" {
  type        = string
  description = "Name for the route table"
  
}

variable "ami_id" {
  type        = string
    description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
}


