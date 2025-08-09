#!/bin/bash

# Destroy infrastructure locally
echo "Destroying infrastructure..."

cd terraform

# Initialize terraform
terraform init

# Destroy all resources
terraform destroy -auto-approve

echo "Infrastructure destroyed successfully!"