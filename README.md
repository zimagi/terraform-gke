# Zimagi Cluster on GKE

## Introduction

Terraform module for deploy a gke cluster for Zimagi cluster. Provisioning contains the following resources:

* VPC
* Subnet
* Kubernetes Controle Plane
* Linux Node Pool
* IAM Service Acccount

## Folder structure

The root folder contains the terraform configuration of provisioning, test folder, circleci configuration and examples folder.

* Root module files:
  * main.tf: contains the logic of provisioning
  * outputs.tf: register attributes of deployed resources
  * variables.tf: varaiable definition of module
  * versions.tf: terraform's provider version requirements
* Circleci: ./.circle folder contains the jobs of the cicd project
* test: automated tests are found here
* examples: preconfigured examples
## Configure cluster

Module can be configured by .tfvars file.
