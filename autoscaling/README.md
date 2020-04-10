1. Login to AWS console, switch to proper AWS account (if you are using multiple accounts) and go to VPC Management Console.
  a. Go to VPC section, select Your VPCs section and write down VPC ID.
  b. Go to Subnets section, choose private subnet and write down its ID as well as Availability Zone that it's bound to.
Note: In Smartling we're marking subnets with AWS tags so that it's easy to identify private and public subnets without digging into routing tables they are associated with.
3. Specify collected data in terraform configuration:
  a. Go to w2 directory in cloned Smartling/aws-terraform-workshops git repository.
  b. Edit file terraform.tfvars: specify VPC ID, Subnet ID and AZ, for example:
$ cat terraform.tfvars
vpc_id = "vpc-1234567"
subnet_id = "subnet-1234567"
availability_zone_id = "us-east-1c"
4. Follow terraform documentation for ASG and comments in autoscaling.tf file to complete Auto Scaling Group and Launch Configuration.
  a. Add missing names for terraform resources.
  b. Configure launch configuration to create one t2.micro instance in security group that is created in ec2.tf file.
  c. Set min_size = 1 and max_size = 3 in ASG, cooldown 60 seconds.
  d. Make sure user-data for EC2 instances in ASG contains your public SSH key.
  e. Apply terraform configuration:
$ terraform plan
$ terraform apply
Note #1: always run terraform plan before apply and examine what is actually terraform is going to change/create/delete in AWS.
Note #2: you need to configure terraform with your AWS credentials here. There're multiple ways to do it and you can find one in our  AWS/Terraform Workshop #1.
  f. Check newly created ASG in AWS EC2 Management Console. You should see Auto Scaling group, Launch Configuration and EC2 instance created by ASG.
5. Uncomment code in terraform configuration files to create CloudWatch (CW) alarm to trigger ASG scaling up policy if total CPU load in ASG is more than 40%.
  a. Enable EC2 detailed monitoring for EC2 instances in ASG so that CloudWatch will collect metrics every 1 minute (Hint: see docs for launch config terraform resource).
  b. Configure CW alarm to add +1 instance if CPU load in ASG is more than 40%, cooldown = 60.
  c. Use CW alarm ARN to reference it in template.
  d. Apply terraform configuration.
  e. Check CW alarm in AWS web console.
6. Enable scaling protection for EC2 instance.
  a. Find your autoscaling group in AWS EC2 Management Console and go to "Instances" tab.
  b. Select and instance, click on "Actions->Instance protection->Set scale in protection".
7. Generate CPU load to trigger CloudWatch alarm and ASG scaling up process.
  a. Login to EC2 instance via SSH and run the following commands:
$ dd if=/dev/urandom bs=1M count=200096 | gzip -9 |gzip -9 | gzip -9 >/dev/null
  b. Review ASG events in AWS web console, see +2 instances in 2 minutes. You can see it in Activity History tab for ASG.
8. Add scale down policy to remove 1x Ec2 instance in case CPU load in ASG is less than 35%.
  a. Create new CW alarm that will trigger scale down ASG policy.
  b. Apply terraform configuration.
9. Watch scaling activity for Auto Scaling Group.
10. Destroy AWS resources.
  a. Disable protection for instance in AWS web console.
  b. Run destroy command:
$ terraform destroy
Note: It will take slightly more time to terminate all resources in AWS than in previous workshop.