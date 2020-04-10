# Create S3 bucket that will be used to store terraform remote state
# Make sure that versioning is enabled for bucket

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key 
  region     = var.region
}


resource "aws_s3_bucket" "tf-remote-state-bucket" {
  bucket = "tf-daniel-jenkins-scripts"
  acl = "private"
  versioning {
    enabled = true
  }
}
