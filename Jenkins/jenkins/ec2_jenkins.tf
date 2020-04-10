# Add missing and/or incomplete arguments to ec2 instance resource below.
# This instance will run Jenkins server, consider this when configuring it.


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key 
  region     = var.region
}

resource "aws_instance" "jenkins_ec2_instance" {

  availability_zone = var.availability_zone_id
  vpc_security_group_ids = [ aws_security_group.jenkins-sg.id ]
  subnet_id = var.subnet_id

  tags = {
    Name = "jenkins-instance"
  }

  user_data = data.template_file.user_data_template.rendered

  # Keep these arguments as is:
  ami = "ami-cb2305a1"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.jenkins-profile.name
  depends_on = [ aws_s3_bucket_object.jenkins_bootstrap_script ]
}

data "template_file" "user_data_template" {
  template = file("files/user-data.txt.tmpl")

  vars = {
    s3_bucket_name = aws_s3_bucket.bootstrap_scripts.bucket
  }
}

