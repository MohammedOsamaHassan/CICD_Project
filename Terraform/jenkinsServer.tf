# Jenkins Server
resource "aws_instance" "myjenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.mykeypair.id
  subnet_id     = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_security_group.myjenkins_sg.id]
  
  tags = {
    Name = "myjenkins_server"
  }
}