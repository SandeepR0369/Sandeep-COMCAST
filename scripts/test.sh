#!/bin/bash

# Specify variables
STACK_NAME=my-static-site-stack
REGION=us-east-1

# Fetch CloudFront distribution domain name from CloudFormation stack outputs
CLOUDFRONT_DOMAIN_NAME=$(aws cloudformation describe-stacks \
    --region $REGION \
    --stack-name $STACK_NAME \
    --query "Stacks[0].Outputs[?OutputKey=='CloudFrontDistributionDomainName'].OutputValue" \
    --output text)

if [ -z "$CLOUDFRONT_DOMAIN_NAME" ]; then
    echo "Failed to retrieve CloudFront domain name."
    exit 1
fi

# Test for 200 OK response
if curl -s -o /dev/null -w "%{http_code}" "https://${CLOUDFRONT_DOMAIN_NAME}" | grep -q 200; then
    echo "Test Passed: Received 200 OK from https://${CLOUDFRONT_DOMAIN_NAME}"
else
    echo "Test Failed: Did not receive 200 OK from https://${CLOUDFRONT_DOMAIN_NAME}"
    exit 1
fi
