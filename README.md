# Introduction

This is a demo of how to deploy a ASM in a multi-project setup. The [documentation](https://cloud.google.com/service-mesh/v1.8/docs/gke-install-overview) shows how to deploy ASM using `gcloud`, but we are going to use Terrafrom to build the full infrastructure. We will first start by setting up the environment. This is meant to be run from a local workstation or CloudShell. The infrastructure setup is split into three parts foudations, IAM and gke.

## Foundations

Three projects are going to be created as part of our foundations. The three projects are going to be created withing the same folder. One of the projects is going to be the host project that will host the shared VPC and the `fleet`. The second and third projects are going to host GKE clusters.

### Deploy foundations

To deploy the foundations first clone the project then `cd infrastucre/foundations` and run
```
terraform init
terraform plan
terraform apply -f default.tfvars
```

my `default.tfvars` file looks like this
```
org_id           = "xxxxx" # Your OrgId
billing_id       = "xxx-xxx-xxx" # Your Billing ID
provisionning_ip = "xxx.xxx.xxx.xxx" # This is the IP you need to whitelist to access your k8s cluster. I am using my local IP "$(dig +short myip.opendns.com @resolver1.opendns.com)"
```

Once the foundations is deployed move to deploy IAM

### Deploy IAM

To deploy the foundations first clone the project then `cd infrastucre/iam` and run
```
terraform init
terraform plan
terraform apply -f default.tfvars
```

This should setup the right IAM. Once done move to deploy GKE

### Deploy GKE and ASM

To deploy the foundations first clone the project then `cd infrastucre/gke` and run
```
terraform init
terraform plan
terraform apply -f default.tfvars
```

This should setup the GKE along with ASM

## Test

To test that everything is working we deploy a sample app. To do that run the script `test.sh`.

# Congratulation

You hav succeffully deployed a multi-project ASM setup using terraform.

# TODO

Use remote state file instead of local state file
