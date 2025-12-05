**Terraform – AWS EC2 Deployment (Ubuntu)

This project uses Terraform to:

Generate SSH Key Pair (.pem)

Create a Security Group allowing SSH

Launch an EC2 instance (Ubuntu - Free Tier eligible)

Use Default VPC and Subnet

Auto-assign Public IP

Prerequisites

Ensure the following tools are installed on your system:

Tool	Check Version
Terraform	terraform -version
AWS CLI	aws --version
unzip (Ubuntu)	sudo apt install unzip -y
AWS CLI Setup (Required)

Create an IAM User in AWS
Attach policy: AdministratorAccess
Download Access Key and Secret Key

Configure AWS credentials:

aws configure


Enter:

AWS Access Key ID: your_key
AWS Secret Access Key: your_secret
Default region name: ap-south-1
Default output format: json


Verify the credentials:

aws sts get-caller-identity

Project Structure
terraform-demo/
main.tf
variables.tf
outputs.tf
.gitignore
demo-key.pem (generated automatically after terraform apply)

How to Run Terraform

Initialize Terraform:

terraform init


Preview the execution plan:

terraform plan


Apply the configuration:

terraform apply


Type "yes" when prompted.

Connect to EC2 Instance

Get the EC2 Public IP:

terraform output instance_public_ip


Connect using SSH:

chmod 400 demo-key.pem
ssh -i demo-key.pem ubuntu@<PUBLIC_IP>

Destroy EC2 Resources

To remove the infrastructure:

terraform destroy


Type "yes" when asked.

Files Not to Push to GitHub

These files should remain private:

demo-key.pem
terraform.tfstate
.terraform/
.terraform.lock.hcl
aws/

awscliv2.zip
