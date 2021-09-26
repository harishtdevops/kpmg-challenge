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
1.  VPC - Private Network Cloud for network layer
2.  subnets - subnets in different Availabilty zones
3.  IGW - Internet Gateway attached to Public Subnets
4.  NAT - NAT Gateway attached to Private subnetes
5.  Security Groups - Network rules to allow access to resources for certain ports
6.  Auto scaling group - Auto scale-in or scale-out of ec2 instances based on the load it receives
7.  EC2 - EC2 instance for hosting web and app layer
8.  RDS - RDS instance for hosting Databases where Multi-AZ is available
9.  Application Load balancer - For High availablilty of application
10. S3 - For Loadbalancedr logs

For web layer it creates an EC2 instance maped to ALB ( Application Load Balancer) using Listener with Port-80 in Public subnet
For Application Layer it creates an Auto-scaling group with min-2 EC2 instances maped to INternal-ALB ( Application Load Balancer) in Private subnet
For DB Layer it creates an RDS instance in Private subnet (mutli-AZ available)


##Architecture 

