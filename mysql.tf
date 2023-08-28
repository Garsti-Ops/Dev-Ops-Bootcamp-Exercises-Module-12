data "aws_eks_cluster" "eks-cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = module.eks.cluster_id
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.eks-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority.0.data)
}

resource "kubernetes_namespace" "myapp" {
  metadata {
    name = "myapp"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks-cluster.endpoint
    token                  = data.aws_eks_cluster_auth.eks-cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority.0.data)
  }
}

resource "helm_release" "mysql_database" {
  name       = "mysql"
  repository = "oci://registry-1.docker.io/bitnamicharts/mysql"
  chart      = "mysql"
  version    = "8.8.6"

  values = [
    "${file("mysql-values.yaml")}"
  ]
}