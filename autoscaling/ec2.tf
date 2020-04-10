provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = "us-east-1"
}



resource "aws_security_group" "asg_security_group" {
  description = "W2 security group."
  name = "terraform-sg"
  # vpc_id = "vpc-05ff6b60"
  vpc_id = var.vpc_id
}


resource "aws_security_group_rule" "ssh_ingress_access" { 
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = aws_security_group.asg_security_group.id 
}


resource "aws_security_group_rule" "egress_access" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.asg_security_group.id
}

resource "aws_security_group_rule" "http_ingress_access" { 
  type = "ingress"
  from_port = 0
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = aws_security_group.asg_security_group.id 
}

resource "aws_instance" "terraform-instance" {
  instance_type = "t2.nano"
  vpc_security_group_ids = [ aws_security_group.asg_security_group.id ]
  associate_public_ip_address = true
  user_data = file("../shared/user-data.txt")
  
  ami = "ami-cb2305a1"
  # availability_zone = "us-east-1f"
  availability_zone = var.availability_zone_id

  # This is fake VPC subnet ID, please put real one to make this config working
  # subnet_id = "subnet-ba6feab6"
  subnet_id = var.subnet_id
}
