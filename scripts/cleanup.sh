#!/bin/bash

# Specify variables
STACK_NAME=my-static-site-stack
REGION=us-east-1

# Delete the CloudFormation stack
aws cloudformation delete-stack \
    --region $REGION \
    --stack-name $STACK_NAME

echo "Initiated deletion of the stack: $STACK_NAME."
