## Challenge 1

## Problem Statement

> A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.


## Solution

# Pre-requesties
1. Terraform to be installed on machine where the scripts needs to be executed `terraform --version`

# Command to run 
Run the below commands to create the infrastructure on aws cloud using Terraform scripts
`terraform init`
`terraform plan`
`terraform apply`

It creates the below services :
VPC - Private Network Cloud for network layer
subnets - subnets in different Availabilty zones
IGW - Internet Gateway attached to Public Subnets
NAT - NAT Gateway attached to Private subnetes
Security Groups - Network rules to allow access to resources for certain ports
Auto scaling group - Auto scale-in or scale-out of ec2 instances based on the load it receives
EC2 - EC2 instance for hosting web and app layer
RDS - RDS instance for hosting Databases where Multi-AZ is available
Application Load balancer - For High availablilty of application
S3 - For Loadbalancedr logs

For web layer it creates an EC2 instance maped to ALB ( Application Load Balancer) using Listener with Port-80 in Public subnet
For Application Layer it creates an Auto-scaling group with min-2 EC2 instances maped to INternal-ALB ( Application Load Balancer) in Private subnet
For DB Layer it creates an RDS instance in Private subnet (mutli-AZ available)


##Architecture 
