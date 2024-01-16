#!/bin/bash

echo 'Start building AMI...'
# Redirect both standard output and standard error to a log file
ARTIFACT=$(packer build aws-ubuntu.pkr.hcl 2>&1 | tee packer_log.txt | grep -E 'ami-' | tail -n 1)
AMI_ID=$(echo $ARTIFACT | cut -d ':' -f2 | tr -d '[:space:]')
echo 'Finish building AMI...'
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivar.tf
cat packer_log.txt