/* Terraform Block
   contains settings including the provider(s) to provision */

terraform {
  required_providers {
    aws = {
      # short for registry.terraform.io/hashicorp/aws
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


/* Provider Block
   declare the specified provider and other settings */

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


/* Resource Block
   The resources to build (EC2, S3 bucket, etc.)       
resource <resource type> <resource name>  */

resource "aws_instance" "app_server1" {
  # ami points to an ubuntu image (these are unique per region)
  ami = "ami-0d56310550de8842f"
  #ami = "ami-0f2cab5c4fce11488" ### Public Ubuntu AMI
  # size of the machine is t2.micro
  instance_type = "t2.micro"
  # tag is metadata information
  tags = {
    Name = var.ec2_instance
  }
}
