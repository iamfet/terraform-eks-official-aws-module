# terraform-eks-official-aws-module

This repository provides a Terraform module for deploying an Amazon EKS (Elastic Kubernetes Service) cluster on AWS using official and community best practices.

## Features

- Creates an EKS cluster with configurable node groups
- Supports custom VPC configuration
- Integrates with AWS IAM, KMS, and other AWS services
- Modular structure for easy customization and extension

## File Structure

```
├── eks-main.tf          # Main EKS cluster and VPC configuration
├── variables.tf         # Input variables
├── outputs.tf          # Output values
├── providers.tf        # Provider configuration
├── terraform.tfvars    # Variable values
└── README.md          # This file
```

## Example `terraform.tfvars`

```hcl
# Example terraform.tfvars

project_name          = "my-eks-project"
vpc_cidr_block        = "10.0.0.0/16"
private_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets_cidr   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
kubernetes_version    = "1.27"
```

## Usage

1. **Clone the repository:**
   ```sh
   git clone https://github.com/iamfet/terraform-eks-official-aws-module.git
   cd terraform-eks-official-aws-module
   ```

2. **Edit `terraform.tfvars`:**
   - Update variable values as needed

3. **Initialize Terraform:**
   ```sh
   terraform init
   ```

4. **Plan the deployment:**
   ```sh
   terraform plan
   ```

5. **Apply the configuration:**
   ```sh
   terraform apply
   ```

## Cleanup

To destroy all resources created by this configuration:
```sh
terraform destroy
```

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS credentials configured (via environment variables or AWS CLI)

## Providers

- [hashicorp/aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) (~> 5.0)

## Inputs

See [`variables.tf`](variables.tf) for a full list of input variables and their descriptions.

## Outputs

- `cluster_name` - Name of the EKS cluster
- `cluster_endpoint` - Endpoint for EKS control plane

See [`outputs.tf`](outputs.tf) for complete output definitions.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

