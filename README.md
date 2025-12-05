 Terraform - AWS EC2 Deployment (Ubuntu)

This project uses Terraform to automatically:

Generate SSH Key Pair (.pem)

Create a Security Group (Allow SSH)

Launch an EC2 Instance (Ubuntu - Free Tier Eligible)

Use Default VPC & Subnets

Auto-assign Public IP

 Prerequisites

Make sure the below tools are installed:

Tool	Check version
Terraform	terraform -version
AWS CLI	aws --version
unzip (Ubuntu)	sudo apt install unzip -y
 AWS CLI Setup (Required)

Create an IAM user in AWS → Attach AdministratorAccess → Download Access Key & Secret Key.

Configure AWS credentials in Ubuntu:

aws configure


Enter:

AWS Access Key ID: your_key
AWS Secret Access Key: your_secret
Default region name: ap-south-1
Default output format: json


To verify:

aws sts get-caller-identity

 Project Structure
terraform-demo/
│-- main.tf
│-- variables.tf
│-- outputs.tf
│-- .gitignore
│-- demo-key.pem (auto created)

 How to Run Terraform
Step 1 — Initialize Terraform
terraform init

Step 2 — Preview changes (Optional)
terraform plan

Step 3 — Apply the changes
terraform apply


Type yes when asked.

Step 4 — Connect to EC2

Get public IP:

terraform output instance_public_ip


Connect:

chmod 400 demo-key.pem
ssh -i demo-key.pem ubuntu@<PUBLIC_IP>

 Destroy EC2 Instance

To remove everything created by Terraform:

terraform destroy


Type yes

 Files NOT to Push to GitHub

The following files should stay private:

demo-key.pem

terraform.tfstate

.terraform/

These are added in .gitignore.