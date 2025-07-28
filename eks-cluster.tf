data "aws_availability_zones" "azs" {
  state = "available"
} #queries AWS to provide the names of availability zones dynamically

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name            = "${var.project_name}-vpc"
  cidr            = var.vpc_cidr_block
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr
  azs             = data.aws_availability_zones.azs.zone_ids

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.project_name}-eks-cluster" = "shared" # Tags required for EKS to discover subnets
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.project_name}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                                = 1 # Identifies this subnet for external load balancers
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.project_name}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                       = 1 # Identifies this subnet for internal services
  }
}




module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${var.project_name}-eks-cluster"
  kubernetes_version = var.kubernetes_version

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  enable_cluster_creator_admin_permissions = true
  endpoint_public_access                   = true

  addons = {
    coredns                = {}
    eks-pod-identity-agent = { before_compute = true }
    kube-proxy             = {}
    vpc-cni                = { before_compute = true }
  }

  eks_managed_node_groups = {
    dev = {
      instance_types = ["t2.large"]

      min_size     = 1 # Auto-scaling configuration
      max_size     = 3
      desired_size = 3
    }
  }


  tags = {
    environment = "dev"
    Terraform   = "true"
  }
}

