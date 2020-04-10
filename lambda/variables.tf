variable "access_key" {
  description = "Access key to login AWS."
  default = "AKIAIGFUQUMOKT56CUDQ"
}


variable "secret_key" {
  description = "Secret key to login AWS."
  default = "/glj1JgpUbY4yBe0PxBn3NBENaO4DiDogvsNAQuT"
}

variable "region" {
  description = "AWS default region."
  default = "us-east-1"
}


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

