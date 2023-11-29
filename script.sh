#!/bin/bash

for arg in "$@"; do
  case "$arg" in
    operation=*) opr="${arg#*=}" ;;
    env=*) env="${arg#*=}" ;;
    stack=*) stack="${arg#*=}" ;;
    *) echo "Unknown argument: $arg" ;;
  esac
done

if [[ $opr == "init" ]]; then
    rm -rf stacks/$stack/.terraform
    export env=$env
    export stack=$stack
    bucket="terraform-stack-$env-bucket" #Update with bucket name you created
    cd stacks/$stack && terraform init -backend=true -backend-config="bucket=$bucket" -backend-config="key=$stack.tfstate" -backend-config="region=us-east-1" #Change region accordingly
    cd ~-
fi

if [[ $opr == "plan" ]]; then
    cd stacks/$stack && terraform plan -input=false -compact-warnings --var-file=../../configs/$stack/$env.tfvars --var-file=../../configs/common.tfvars
    cd ~-
fi

if [[ $opr == "apply" ]]; then
    cd stacks/$stack && terraform apply -compact-warnings -auto-approve -input=false -compact-warnings --var-file=../../configs/$stack/$env.tfvars --var-file=../../configs/common.tfvars
    cd ~-
fi

if [[ $opr == "destroy" ]]; then
    cd stacks/$stack && terraform destroy -auto-approve -input=false -compact-warnings --var-file=../../configs/$stack/$env.tfvars --var-file=../../configs/common.tfvars
    cd ~-
fi