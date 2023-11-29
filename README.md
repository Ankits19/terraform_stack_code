# Terraform Stack Guide

This repo is created to replicate infrastructure using terraform stack and help user to explain terraform structure with practical example.

This repo consist basic code with two stacks to have simple web application up and running in AWS cloud.

Below are the stacks used in this example:

* **Network**: This stack will be used to create resources like vpc, subnets and internet gateway to prepare base networking for our application

* **Frontend**: This stacks creating resource like EC2 instance, Load Balance and network connection between EC2 and load balancer to forward traffic from web. 


**Note**: This is just for example, in real world application we have multiple stacks grouping together to have application up and running.

In this repo, you will find ``` script.sh``` , shell script to use automation way to deploy multiple stacks for different environment.

### Prerequisites

To run and start with terraform operations, you need to perform some pre-requisites. Please make sure your IAM user have permissions to create EC2 resoruces.

Export right AWS credentials to your terminal, for **linux/mac**
```
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2
```

Export right AWS credentials to your terminal, for **windows**
```commandline
setx AWS_ACCESS_KEY_ID AKIAIOSFODNN7EXAMPLE
setx AWS_SECRET_ACCESS_KEY wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
setx AWS_DEFAULT_REGION us-west-2
```

Backend bucket created, Make sure you create bucket in your preferred region with and update **script.sh** and **data.tf** in frontend stack. 


#### Usage of automation script

Run below commands from root directry of repo, below commands are for **dev** environment specifically, environment you can changeif you want to deploy resources in multiple environments.

#### Network stack
###### Terrform init operation
```commandline
. ./script.sh operation=init env=dev stack=network
```
![Network_init](./docs/network_init.png)

###### Terrform plan operation
```commandline
. ./script.sh operation=plan
```

###### Terrform apply operation
```commandline
. ./script.sh operation=plan
```

#### Frontend stack
###### Terrform init operation
```commandline
. ./script.sh operation=init env=dev stack=frontend
```
![Network_init](./docs/frontend_init.png)

###### Terrform plan operation
```commandline
. ./script.sh operation=plan
```

###### Terrform apply operation
```commandline
. ./script.sh operation=plan
```

After successful terraform apply operation you be getting DNS output of load balancer to access your application.

### Important step

To avoid extra cost incurred for your resource, don't forget to destory resources.

**_Destroy Frontend stack_**
```commandline
. ./script.sh operation=init env=dev stack=frontend
```

```commandline
. ./script.sh operation=destroy
```

**_Destroy Network stack_**
```commandline
. ./script.sh operation=init env=dev stack=network
```

```commandline
. ./script.sh operation=destroy
```