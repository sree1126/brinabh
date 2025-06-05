resource "aws_eks_cluster" "brinabh_eks_cluster" {
  name = "brinabh_eks_cluster"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.brinabh_eks_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.brinabh_private_subnet_east-1a.id,
      aws_subnet.brinabh_private_subnet_east-1b.id,
      aws_subnet.brinabh_public_subnet_east-1a.id,
      aws_subnet.brinabh_public_subnet_east-1b.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.brinabhAmazonEKSClusterPolicy
  ]
}