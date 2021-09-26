#!/bin/bash
set -e

if [ "$#" -ne 2 ];
then
   echo ERROR : Invalid arugments passed....Please pass 2 arguments
   echo Arugment 1 : AWS Region
   echo Argument 2 : EC2 instance ID
   exit 1;
fi

aws ec2 --region $1 describe-instances --instance-id "$2" || { echo "ERROR :: Invalid Arguments passed" ; exit 1; }