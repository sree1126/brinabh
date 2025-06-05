data "tls_certificate" "brinabh_certificate" {
  url = aws_eks_cluster.brinabh_eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "brinabh_openid_connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.brinabh_certificate.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.brinabh_eks_cluster.identity[0].oidc[0].issuer
}