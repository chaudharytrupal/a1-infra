# Terraform Project Setup

Follow these steps to set up and deploy the infrastructure:

## Step 1: Clone the Repository

## Step 2: cd into the cloned repo

```bash
cd a1-infra
```

## Step 3: Create ssh file

```bash
ssh-keygen -t rsa -f ~/.ssh/my_key
```

## Initialize and deploy infrastructure

```bash
terraform init
terraform apply -auto-approve
```
