# Master Node
resource "aws_instance" "myk8s_master" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair.id
  subnet_id     = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_security_group.myk8s_master_sg.id]
  
  tags = {
    Name = "myk8s_master"
  }
}

# Worker Node
resource "aws_instance" "myk8s_worker1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair.id
  subnet_id     = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_security_group.myk8s_worker_sg.id]
  
  tags = {
    Name = "myk8s_worker1"
  }
}

resource "aws_instance" "myk8s_worker2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair.id
  subnet_id     = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_security_group.myk8s_worker_sg.id]
  
  tags = {
    Name = "myk8s_worker2"
  }
}