## 1. Create EC2 instance with IAM role with full access to AWS.
Note: there are no intentional mistakes or confusions at this step. But next sections in this workshop still contain some so you'll need to fix them.
a. Go to w6/workshop_part_1 directory in cloned Smartling/aws-terraform-workshops git repository.
b. Configure terraform to create IAM role, security group and EC2 instance.
c. Make sure that user data for EC2 instance contains your SSH key.
d. Apply terraform configuration:
$ terraform plan
$ terraform apply
e. Login to newly created EC2 instance via SSH.
f. Checkout git repository with terraform workshops.
$ git clone https://github.com/Smartling/aws-terraform-workshops
$ cd w6/workshop_part_2


## 2, Create ASG and ECS cluster with EC2 instance registered in it.
Note: Credentials for Terraform are not required for these steps as “terraform apply” will be executed on EC2 instance which has full access to AWS.
a. Go to w6/workshop_part_2 directory at newly created EC2 instance and configure terraform to create ECS cluster. You may use mcedit, vim or nano command line text editors.
b. Apply terraform configuration:
$ terraform plan
$ terraform apply
Note: At this step you should run terraform in w6/workshop_part_2 directory at newly created EC2 instance.
c. Go to AWS ECS console to see newly created ECS cluster.
d. Configure terraform to create Auto Scaling Group and instances registered in this ECS cluster.
e. Check AWS ECS web console to see new container instance.


## 3, Create ECS service with ELB attached to it.
a. Configure terraform to create sample ECS service with ELB.
  i. Notice ignore_changes configuration in ECS service definition.
  ii. Apply Terraform configuration.
$ terraform plan
$ terraform apply
b. Use ELB DNS name to open sample service in browser: check events for ECS service in AWS web console to see why tasks aren’t starting at container instance.
c. Adjust terraform configuration and apply it to fix the issue.


## 4, Initiate deployment to ECS service.
a. Change docker image name from anosulchik/workshop-sample-application:v1.0 to anosulchik/workshop-sample-application:v2.0 in containers.txt that defines containers in ECS task.
b. Apply Terraform configuration.
$ terraform plan
$ terraform apply
c. Use ELB DNS name to open sample service in browser: You should see the new version v2.0 of the sample application here.


## 5. Create Lambda function to sync ASG desired EC2 instances capacity with ECS desired tasks count.
a. Configure terraform to bind SNS topic used by ASG to send notifications to trigger Lambda function.
b. Apply Terraform configuration.
$ terraform plan
$ terraform apply
c. Uncomment resource in lambda.tf and apply terraform configuration.
d. Change min_size = max_size = 2 in ASG configuration.
e. Check Lambda function’s logs and ECS service desired count value in web console (you should see desired_count = 2 here applied by Lambda).
f. Change min_size = max_size = 1 in ASG configuration.


## 6. Destroy AWS resources created in this workshop.
Note: Order is extremely important here — run Terraform destroy at EC2 instance first, then locally.
a. Run “terraform destroy” command on EC2 instance where you logged into via SSH, in the w6/workshop_part_1 directory.
b. Run “terraform destroy” on your computer in w6/workshop_part_2 directory.
