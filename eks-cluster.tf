

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name    = "${var.project_name}-eks-cluster"
  cluster_version = var.cluster_version

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id     = module.myapp-vpc.vpc_id

  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access           = true


  tags = {
    environment = "development"
    application = "${var.project_name}"
  }


  eks_managed_node_groups = {
    dev = {
      instance_types = ["t2.large"]

      min_size     = 1 # Auto-scaling configuration
      max_size     = 3
      desired_size = 3
    }
  }





}

