# Uncomment resources below and add required arguments.

resource "aws_security_group" "w1_security_group" {
  # 1. Define logical names (identifiers) for resource.
  #    E.g.: resource "type" "resource_logical_name" {}
  #    Docs: https://www.terraform.io/docs/providers/aws/r/security_group.html

  # 2. Set psysical name of your security group below in format "yourname-"
  name = "terraform-sg"

  # description = "Test security group."
  # vpc_id = "vpc-05ff6b60"
  vpc_id = var.vpc_id
}

# To reference attributes of resources use syntax TYPE.NAME.ATTRIBUTE
#   for example, in order to create rule in specific secrurity group you will have to
#   refer security group by its name :
#     security_group_id = "${aws_security_group.mysecuritygroup.id}"
#
# Reference: https://www.terraform.io/docs/configuration/interpolation.html


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key 
  region     = var.region
}



resource "aws_security_group_rule" "ssh_ingress_access" { 
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = aws_security_group.w1_security_group.id 
}

resource "aws_security_group_rule" "egress_access" {
  # 1. Add required arguments to open outgoing traffic to all ports (0-65535) 
  # 2. Add argument to reference Security Group resource.
  # Docs: https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
  
  # ...
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.w1_security_group.id
}

resource "aws_security_group_rule" "http_ingress_access" { 
  type = "ingress"
  from_port = 0
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = aws_security_group.w1_security_group.id 
}

resource "aws_instance" "terraform-instance" {
  instance_type = "t2.nano"
  vpc_security_group_ids = [ aws_security_group.w1_security_group.id ]
  associate_public_ip_address = true
  user_data = file("../shared/user-data.txt")
  
  ami = "ami-cb2305a1"
  # availability_zone = "us-east-1f"
  availability_zone = var.availability_zone_id
  
  # This is fake VPC subnet ID, please put real one to make this config working
  # subnet_id = "subnet-ba6feab6"
  subnet_id = var.subnet_id
}

