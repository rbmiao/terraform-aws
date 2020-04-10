# Keep this file as is.


provider "aws" {
    access_key = var.access_key 
    secret_key = var.secret_key  
    region     = var.region  
}




resource "aws_instance" "ec2-instance" {
  instance_type = "t2.nano"
  vpc_security_group_ids = [  aws_security_group.ec2-sg.id  ]
  associate_public_ip_address = true
  user_data =  file("../user-data.txt") 

  iam_instance_profile =  aws_iam_instance_profile.ec2-profile.name 

  ami = "ami-cb2305a1"
  availability_zone =  var.availability_zone_id 
  subnet_id =  var.subnet_id 

  depends_on = [ aws_iam_instance_profile.ec2-profile  ]
}
