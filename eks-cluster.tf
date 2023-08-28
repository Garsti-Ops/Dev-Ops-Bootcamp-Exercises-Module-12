variable "eks_cluster_name" {}
variable "env_prefix" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.27"

  subnet_ids = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    # blue = {}
    # green = {}
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t2.micro"]
      labels = {
        Environment = var.env_prefix
      }
    }
  }

  fargate_profiles = {
    default = {
      name = "myapp-profile"
      selectors = [
        {
          namespace = "myapp"
        }
      ]
    }
  }
}

