# Specify missing arguments here. Leave existing ones as is.

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2-role.name 
}

resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3-policy" {
  name = "aws-full-access"
  role =  aws_iam_role.ec2-role.id 
  policy = <<EOF
{
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "*"
    ],
    "Resource": "*"
  }]
}
EOF
}
