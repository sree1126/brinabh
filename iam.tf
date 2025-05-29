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
