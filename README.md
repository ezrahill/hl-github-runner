# Terraform Proxmox VM Provisioning for Self-Hosted GitHub Actions Runners

This project automates the provisioning of virtual machines on a Proxmox server and configures GitHub Actions runners on these VMs using Ansible.

## Overview

The Terraform configuration provisions a VM on a Proxmox server and configures its network settings. Post-provisioning, Ansible takes over to install and configure GitHub Actions runners dynamically across multiple repositories.

### Terraform

Terraform is used to set up a virtual machine with specific configurations:

- **VM Configuration**: Utilizes Proxmox API to clone an existing VM template.
- **Network Configuration**: Sets up network interfaces with predefined MAC addresses and IP configurations.

### Ansible

Ansible is deployed to configure the provisioned VMs by installing necessary packages, copying scripts, and setting up GitHub Actions runners:

- **Dynamic Repository Setup**: Configures GitHub Actions runners for a list of repositories.

## Prerequisites

- Proxmox server with API access.
- Ubuntu VM template pre-configured with cloud-init.
- Ansible and Terraform installed on your local machine or a CI/CD pipeline.
- Access to GitHub repository and a Personal Access Token with appropriate permissions (Repository Admin Write).

## Setup

### Configuration Files

1. **Terraform Variables**:
   - `variables.tf`: Defines necessary input variables such as Proxmox API details and VM specifications.

2. **Ansible Variables**:
   - `secrets.yaml`: Contains encrypted secrets like GitHub Personal Access Token. (Ensure this file is never uploaded to version control).
   - `repos.yaml`: Contains a list of repositories to set up GitHub Actions runners. (This file should also be kept out of version control).
   - `password`: Contains the Ansible Key Vault password. (Ensure this file is never uploaded to version control).

### Initializing Terraform

Navigate to the **self-hosted-runner** directory and run the following commands:

```bash
terraform init
terraform plan
terraform apply
