variable "vpc_cidr_block" {
  default = ""
}
variable "private_subnet_cidr_blocks" {
  default = ""
}
variable "public_subnet_cidr_blocks" {
  default = ""
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block

  azs             = ["eu-central-1a"]
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    App = "myapp"
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/roles/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/roles/internal-elb" = 1
  }
}