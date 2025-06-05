resource "aws_iam_policy" "brinabh_s3_admin" {
  name        = "brinabhS3AdminPolicy"
  description = "Full access to all S3 resources"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:*",
        Resource = "*"
      }
    ]
  })
}

#attach Uer to Above S3 policy to manage S3 buckets
resource "aws_iam_user_policy_attachment" "brinabh_s3_admin_attach" {
  user       = "smerugumala"
  policy_arn = aws_iam_policy.brinabh_s3_admin.arn
}


resource "aws_iam_role" "brinabh_eks_role" {
  name = "brinabh_eks_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "EKSClusterCreation"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "brinabh_eks_role"
  }
}

# eks policy attachment

resource "aws_iam_role_policy_attachment" "brinabhAmazonEKSClusterPolicy" {
  role       = aws_iam_role.brinabh_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


# role for nodegroup

resource "aws_iam_role" "brinabh_eks_nodes" {
  name = "brinabh-eks-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# IAM policy attachment to nodegroup

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.brinabh_eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.brinabh_eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.brinabh_eks_nodes.name
}