## Challenge 2

## Problem Statement

>We need to write code that will query the meta data of an instance within AWS and provide a json formatted output.

## Solution

# Pre-requesties
1. AWS-CLI to be installed on machine where the scripts needs to be executed `aws --version`
2. Configure the AWS Access and secret keys of respective account

# Command to run
Run the script `get_metadata.sh` with arguments as aws region and instance-id
> ./get_metadata.sh  eu-west-2  i-0d3460978f007d79a

It displays the output as below
![image](https://user-images.githubusercontent.com/90919654/134827600-3612d04a-be6e-4454-b5b9-395fe064b0be.png)
