data "aws_iam_policy_document" "brinabh_eks_cluster_autoscaler_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.brinabh_openid_connect.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.brinabh_openid_connect.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "brinabh_eks_cluster_autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.brinabh_eks_cluster_autoscaler_assume_role_policy.json
  name               = "brinabh-eks-cluster-autoscaler"
}

resource "aws_iam_policy" "brinabh_eks_cluster_autoscaler" {
  name = "brinabh-eks-cluster-autoscaler"

  policy = jsonencode({
    Statement = [{
      Action = [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "brinabh_eks_cluster_autoscaler_attach" {
  role       = aws_iam_role.brinabh_eks_cluster_autoscaler.name
  policy_arn = aws_iam_policy.brinabh_eks_cluster_autoscaler.arn
}

output "brinabh_eks_cluster_autoscaler_arn" {
  value = aws_iam_role.brinabh_eks_cluster_autoscaler.arn
}