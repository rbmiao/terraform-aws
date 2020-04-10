# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "lambda" {
  name = "tf-lambda-asg"
  launch_configuration =  aws_launch_configuration.lambda.name 
  load_balancers = [  aws_elb.lambda.name  ]

  availability_zones = [  var.availability_zone_id  ]
  vpc_zone_identifier = [  var.subnet_id  ]
  lifecycle { create_before_destroy = true }
  min_size = 1
  max_size = 1
}

resource "aws_launch_configuration" "lambda" {
  security_groups = [  aws_security_group.lambda.id  ]
  user_data =  file("user-data.txt") 
  image_id = "ami-cb2305a1"
  instance_type = "t2.micro"
  lifecycle { create_before_destroy = true }
}

