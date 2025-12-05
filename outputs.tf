variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_name" {
  description = "Tag name for instance"
  type        = string
  default     = "Demo-instances"
}

variable "key_pair_name" {
  description = "Key pair name"
  type        = string
  default     = "demo-key"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
