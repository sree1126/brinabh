resource "aws_eks_node_group" "brinabh_eks_node_group" {
  cluster_name    = aws_eks_cluster.brinabh_eks_cluster.name
  node_group_name = "brinabh_eks_node_group"
  node_role_arn   = aws_iam_role.brinabh_eks_nodes.arn
  subnet_ids = [
    aws_subnet.brinabh_private_subnet_east-1a.id,
        aws_subnet.brinabh_private_subnet_east-1a.id,
            aws_subnet.brinabh_public_subnet_east-1a.id,
                aws_subnet.brinabh_public_subnet_east-1b.id
                ]
  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 10
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    node = "brinabh_kubenode02"
  }

    # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly
  ]
}

# launch template if required

# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {
#       volume_size = 50
#       volume_type = "gp2"
#     }
#   }
# }