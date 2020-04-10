
variable "vpc_id" {
  description = "VPC ID for AWS resources."
  default = "vpc-05ff6b60"
}

variable "availability_zone_id" {
  description = "AZ used to create EC2 instances."
  default = "us-east-1f"
}

variable "subnet_id" {
  description = "Subnet for EC2 instances."
  default = "subnet-ba6feab6"
}


variable "access_key" {
  description = "AWS access key"
  default = "YOURACCESSKEY"
}

variable "secret_key" {
  description = "AWS secret key"
  default = "YOURSECRETKEY"
}

variable "region" {
  description = "AWS instance region"
  default = "us-east-1"
}
