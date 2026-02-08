# Terraform AWS VPC Project

This repository demonstrates how to provision a simple AWS VPC and Subnet using Terraform with Terraform Cloud (HCP Terraform) as the remote backend for state management.It is designed to reflect real-world best practices and is suitable for DevOps / Cloud interviews.

## Architecture Overview

The Terraform configuration creates:

- An AWS VPC

- A Subnet inside the VPC


**Terraform Cloud** is used to:

- Store the Terraform state file remotely

- Provide state locking

- Enable team collaboration

## Prerequisites

Before running this project, ensure you have:

- An AWS account

- An IAM user or role with permissions for:

   - VPC

   - Subnet

- A Terraform Cloud account

- Terraform CLI installed (v1.3+ recommended)

## Project Structure

```bash
terraform-vpc/
│
├── backend.tf # Terraform Cloud backend configuration
├── providers.tf # AWS provider configuration
├── main.tf # VPC and Subnet resources
├── variables.tf # Input variables
├── outputs.tf # Output values
└── README.md # Project documentation

Note : Terraform loads all .tf files in a directory as a single configuration. File names are for human readability only.

```

## Terraform Cloud Backend Configuration


Terraform Cloud is configured as the remote backend:

- State is stored remotely

- State locking is automatically enabled

- Each workspace represents an environment

**Example (backend.tf):**

```bash
terraform {
  cloud {
    organization = "<your-organization>"

    workspaces {
      name = "vpc-demo"
    }
  }
}
```

## AWS Provider Configuration
The AWS provider is configured without hardcoded credentials.

Credentials are supplied via **Terraform Cloud workspace environment variables.**

Example (providers.tf):

``` bash
provider "aws" {
  region = "us-east-1"
}
```

## Authentication & Credentials
### Terraform Cloud

Run once on your local machine:

```
terraform login
```

### AWS Credentials (Terraform Cloud Workspace)

Set the following Environment Variables in the Terraform Cloud workspace:


| Variable | Description | Sensitive |
| :--- | :--- | :--- |
| `AWS_ACCESS_KEY_ID` | AWS access key | **Yes** |
| `AWS_SECRET_ACCESS_KEY` | AWS secret key | **Yes** |
| `AWS_DEFAULT_REGION` | AWS region | No | 

Credentials should **never** be hardcoded in Terraform files.

## How to Run

### 1. Initialize Terraform

```
terraform init
```

- Initializes the Terraform Cloud backend

- Downloads required providers

### 2. Review the Execution Plan

```
terraform plan
```


- Shows resources to be created

- No infrastructure changes are made

### 3. Apply the Configuration


```
terraform apply
```

- Creates the VPC and Subnet

- State is stored remotely in Terraform Cloud

## Outputs

After a successful apply, Terraform outputs:

- VPC ID

- Subnet ID

These values can be used by other Terraform modules or systems.

## Cleanup

To destroy all resources created by this configuration:

```
terraform destroy
```


This will remove the VPC, Subnet, and all associated resources.