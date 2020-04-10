1. Go to lambda directory in cloned Smartling/aws-terraform-workshops git repository.
2. Create Autoscaling group (ASG), attach ELB to ASG.
a. Finish incomplete terraform configuration and be prepared to fix mistakes.
  
  b. Attach ELB to ASG (do not enable ELB checks for ASG, keep default EC2).
c. terraform plan, terraform apply:
$ aws-profile yourteam-dev terraform plan
$ aws-profile yourteam-dev terraform apply
d. Check AWS resources created in this step.
e. Make sure ELB DNS name can be opened with browser -- it should show nginx welcome page.
3. Create SNS topic, subscribe your email to it.
4. Create Lambda function for monitoring nginx behind ELB, it will send check the results to SNS (and to your mailbox).
a. Finish incomplete terraform configuration to create Lambda function triggered by CloudWatch events every 5 minutes.
b. terraform plan, terraform apply.
c. Go to AWS Lambda console and change check URL and SNS in Lambda function’s code:
Note: Make sure you specified actual DNS name of your ELB (it can be found in AWS web console or in tfstate file)
d. Try to trigger Lambda function in console manually, consider what should be changed in case lambda execution fails.
e. Check lambda function execution logs in CloudWatch.
5. Simulate service outage by stopping nginx at instance in ASG.
a. Options:
i. Go to instance via SSH and run ‘sudo service docker stop’ command to shutdown container with nginx.
ii. Adjust rules in ec2 security group in terraform configuration to prevent ELB from communicating with instance.
b. Check that ELB doesn’t show nginx welcome page in browser anymore.
c. Wait until Lambda function is executed by Cloudwatch schedule.
Make sure your received email about failed web check to your mailbox.
6. Destroy aws resources by corresponding terraform command.
(optional) 7. Change code of Lambda function to send custom metrics into CloudWatch e.g. 1 when web check succeeded and 0 when it failed.