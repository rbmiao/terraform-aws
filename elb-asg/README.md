1. Go to directory in cloned Smartling/aws-terraform-workshops git repository.
2. Specify actual IDs of AWS VPC, Subnet and Availability Zone into terraform.tfvars file.
Note: Follow instructions in Hands On section of Workshop #2 or just copy terraform.tfvars file from it.
3. Add your public SSH key to user-data.txt file.
4. Create Autoscaling Group:
  a. Configure security group for instances in ASG to accept incoming connections via 22 and 80 TCP ports from 0.0.0.0/0.
Note: This is generally bad idea from security perspective to open access to your resources via 22 port from anywhere -- please avoid such setup in configurations other than workshop.
  b. Add missing arguments for ASG in autoscaling.tf file:
    i. Min instances limit = 2, max instances = 2
    ii. Instance type t2.nano
    iii. Add references between AWS resources: attach ASG launch configuration to autoscaling group etc.
Note: Be prepared for mistakes made in terraform configuration intentionally – just fix them.
  c. Apply terraform configuration.
  d. Check newly created AWS resources in AWS web console.
5. Create AWS ELB and attach it to ASG created before.
  a. Uncomment resources in elb.tf and add finish configuration.
  b. Configure ELB Listener to accept HTTP connection on port 80 and forward them to port 80.
  c. Enable connection draining.
  d. Configure ELB health checks:
    i. Ping Target: "HTTP:80/"
    ii. Healthy threshold = 3
    iii. Unhealthy threshold = 3
    iiii. Timeout = 2
    iiiii. Interval = 5
  e. Put ELB in the same Security Group with instances in ASG.
  f. Apply Terraform configuration.
  g. Attach  ELB to ASG:
    i. Update ASG configuration in terraform
    ii. Configure ASG to use ELB metrics instead of EC2
  h. Find ELB endpoint and open it in browser – you should see nginx welcome page.
6. Create SNS topic to receive ASG scaling notifications to email.
  a. Uncomment SNS topic resource in sns.tf file.
  b. Apply terraform configuration
  c. Go to AWS SNS web console, find newly created SNS topic and create subscription to your email address.
  d. Update ASG configuration to send its scaling events to SNS topic
  e. Apply terraform configuration.
  f. Login to one of ec2 instances via SSH and stop docker "sudo service docker stop". ASG will detect that instance in unhealthy (as it doesn't reply to health checks), will terminate it and will create new.
  g. Make sure you received notification from ASG to your email.
7. Destroy AWS resources.