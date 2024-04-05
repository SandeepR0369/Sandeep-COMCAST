#!/bin/bash

# Variables
STACK_NAME="my-static-site-stack"
REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BUCKET_NAME="my-static-website-${ACCOUNT_ID}-${REGION}"

# Deploy CloudFormation Stack
aws cloudformation deploy \
  --region $REGION \
  --stack-name $STACK_NAME \
  --template-file cloudformation/template.yaml \
  --capabilities CAPABILITY_NAMED_IAM

# Upload "Hello World" HTML to S3
echo "Uploading 'Hello World' page to S3..."
aws s3 cp index.html s3://${BUCKET_NAME}/index.html

echo "Deployment completed."
