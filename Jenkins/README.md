1. Go to Jenkins directory.
2. Create S3 bucket for terraform remote state:
  a. cd remote_state, edit file s3.tf
  b. Define S3 bucket in terraform configuration (make sure versioning is enabled for it).
  c. Apply terraform configuration:
$ terraform plan
$ terraform apply
Note: Names of S3 buckets must be unique with AWS S3 service so if anyone already took your bucket name, just use something like mybucket-w4-workshop-yourname.
  d. cd ../jenkins
  e. Configure terraform to use newly created S3 bucket as a remote state:
$ terraform remote config -backend=S3 -backend-config="bucket=mybucket-w4-workshop" -backend-config="key=/terraform.tfstate" -backend-config="region=us-east-1"
  f. Check .terraform/terraform.tfstate file – you should see remote config section there e.g.:
$ cat .terraform/terraform.tfstate
...
"remote": {
        "type": "s3",
        "config": {
            "bucket": "mybucket-w4-workshop",
            "key": "/terraform.tfstate",
            "region": "us-east-1"
        }
    },
...
2. Deploy Jenkins using terraform.
  a. Define missing resources in terraform configuration according to comments *.tf files
  b. Make sure user-data for Jenkins ec2 instance contains your public SSH key terraform plan.
  c. terraform plan and apply
  d. Get public IP address of instance that hosts Jenkins and open http://<ip address>:8000 is browser. You'll be asked to provide password that can be obtained at Ec2 instance so you'll need to access it via SSH.
Note: it takes about 4 minutes for Jenkins to bootstrap before it shows welcome/installation page.
  e. Follow instructions on the screen to install Jenkins.
3. Configure Jenkins to build, test and deploy sample project.
  a. Go to “Manage Jenkins → Manage Plugins” section and install “Git plugin” (use search bar with exact name of plugin).
  b. Make sure you choose to restart Jenkins during the installation.
  c. Create new Project:
     i. Press “create new jobs” at Jenkins, specify Project name, select Freestyle project.
    
     ii. Configure Job with Git repository of sample project (choose some open source project at Github and configure checkout step for it).
     iii. Save changes.
     iiii. Go to newly created Project and press ‘Build Now’ -- look around and check that the build was successful (find out where build’s log can be found).
  d. Add build actions for the project.
     i. Go to Project's configuration.
     ii. Add one or more build steps (choose Execute Shell and add sample commands like "ls -la", "pwd", "date" etc.).
4. Destroy AWS resources using ‘terraform destroy’ command.
$ cd jenkins
$ terraform destroy
 
$ cd ../remote_state
$ terraform destroy
Note: terraform can't delete S3 bucket because it’s not empty so you may need to go to S3 web console and delete all files and all their versions for remote tfstate file.