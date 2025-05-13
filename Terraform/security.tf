# Securiy Groubs
# Jenkins SG
resource "aws_security_group" "myjenkins_sg" {
  name = "jenkins_sg"
  description = "Jenkins ports"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Jenkins port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App port"
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }

}


# Kubernetes SG
# Controlplane

resource "aws_security_group" "myk8s_master_sg" {
  name = "K8SMaster_sg"
  description = "control plane ports"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "K8S API port"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "etcd port"
    from_port = 2379
    to_port   = 2380
    protocol  = "tcp"
    self = true
  } 

  ingress {
    description = "Kubelet port"
    from_port = 10250
    to_port   = 10250
    protocol  = "tcp"
    self = true
  }

  ingress {
    description = "Kube schdeuler port"
    from_port = 10259
    to_port   = 10259
    protocol  = "tcp"
    self = true
  }

  ingress {
    description = "Kube controller manager port"
    from_port = 10257
    to_port   = 10257
    protocol  = "tcp"
    self = true
    
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
    
 } 
  tags = {
    name = "K8SMaster_sg"
  }

}

# Worker Node

resource "aws_security_group" "myk8s_worker_sg" {
  name = "K8SWorker_sg"
  description = "Worker ports"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "Kubelet port"
    from_port = 10250
    to_port   = 10250
    protocol  = "tcp"
    self = true
  }

  ingress {
    description = "Kube proxy port"
    from_port = 10256
    to_port   = 10256
    protocol  = "tcp"
    self = true
  }
  
  ingress {
    description = "NodePort Service port tcp"
    from_port = 30000
    to_port   = 32767
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    description = "NodePort Service port tcp"
    from_port = 30000
    to_port   = 32767
    protocol  = "udp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
    
 } 
  tags = {
    name = "K8SWorker_sg"
  } 
}


# Bastion Host SG
resource "aws_security_group" "mybastion_host_sg" {
  name = "bastion_sg"
  description = "Bastion Host ports"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_sg"
  }
  
}

# Key Pair
resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file("mykey.pub")
}


