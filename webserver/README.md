1. Login to your AWS account console.
2. Clone git repository with workshop data, go to w1 directory:
$ git clone https://github.com/Smartling/aws-terraform-workshops.git
$ cd aws-terraform-workshops/w1
3. Configure Terraform with AWS credentials (see pre-requisites) in creds.tf configuration file:
$ cat creds.tf
provider "aws" {
  access_key = "THISISEXAMPLETHISISEXAMPLE"
  secret_key = “THISISEXAMPLE/kToJ5qUtCpxr/THISISEXAMPLE"
  region = "us-east-1"
}
4. Follow terraform documentation for EC2 instance and comments in ec2.tf to complete configuration:
   4.1. Go to AWS VPC console, write down VPC ID and subnet ID which are required to complete configuration.
Please notice that VPC and subnets are covered in details in the next workshops but they are still required to finish EC2 configuration.
   4.2. Use t2.nano as instance type for EC2 instance.
   4.3. You should specify names for AWS resources as well as missing configuration parameters.
   4.4. In this workshop we need to create EC2 instance in its own security group, see documentation here and here.
   4.5. Run terraform plan to make sure configuration is ready to be applied.
   4.6. Run terraform apply to actually create AWS resources: EC2 security group and EC2 instance.
5. Go to AWS console and find newly created EC2 instance and security group.
6. Open terraform.tfstate to examine its structure and newly created AWS resources. Please don't make any changes into this file. It's managed by terraform so manual changes into this file may break things up.
7. Modify EC2 instance type:
   7.1. Change EC2 instance type from t2.nano to t2.micro.
   7.2. Run terraform plan and then terraform apply to actually apply changes.
   7.3. Check changes in AWS EC2 web console.
8. Add your SSH key to EC2 instance and access it via SSH.
   8.1. Uncomment user_data parameter in terraform config.
   8.2. Replace example SSH key with your public SSH key to shared/user-data.txt file:
cd ../../
$ cat shared/user-data.txt
#!/bin/bash
   
mkdir -p /home/ec2-user/.ssh
cat <<FILE > /home/ec2-user/.ssh/authorized_keys
ssh-rsa AAAAEXAMPLEyc2EAAAADAQABAAABAQCxz1G2vfqCabgFNZiL/timcrISitT4ShZP0iB4G1F+tFRM7to3CstEbS9TFeZwJdKeKLJoGsB5mMueqQb34lVt+ieodNKn8vMjTqv62W8YLqhRavnJ7bTGqGxNhAuLZJdEXAMPLEgywFwQjKYIVQt0SeB0XXLgAUIp+FS7MVyywDdViLqHWexxFN9Nrd6nPAj0fLV9DRIwe7nRccj+R4HvGIC7rQ060QCDCssYiZT/FVihNcPfohQA1JlNGao/lXLkSivwtl0pEDECyzs2KULS+9mc5Bz0Ap1Liskoa5V9umz8LhA9WLqNaCtt6fWQurPAd5lpEXAMPLE user@host
FILE
chown ec2-user.ec2-user /home/ec2-user/.ssh/authorized_keys
chmod 400 /home/ec2-user/.ssh/authorized_keys
yum -y erase docker
   8.3. Apply configuration changes.
   8.4. Login to newly created EC2 instance via SSH.
   8.5. Run commands uptime, top, uname -a on EC2 instance.
9. Run terraform destroy to delete AWS resources which were created during this workshop.
Hint: in case you got stuck during this workshop you can check answers directory in aws-terraform-workshops git repository.