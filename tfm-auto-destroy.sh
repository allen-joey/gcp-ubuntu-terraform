#!/bin/bash

# set -x
# set -e

# Terraform Destroy
echo "Terraform Auto Destroy…"
terraform destroy --auto-approve

exit 0