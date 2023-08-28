resource "aws_eks_fargate_profile" "myapp-profile" {
  cluster_name           = var.eks_cluster_name
  fargate_profile_name   = "myapp-profile"
  pod_execution_role_arn = aws_iam_role.myapp-iam-role.arn
  subnet_ids             = module.vpc.private_subnets

  selector {
    namespace = "myapp"
  }
}

resource "aws_iam_role" "myapp-iam-role" {
  name = "myapp-iam-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "myapp-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.myapp-iam-role.name
}