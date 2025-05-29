resource "aws_s3_bucket" "brinabh_bucket" {
  bucket = "www.brinabh.com"
  website {
    index_document = "index.html"
    # error_document = "error.html"
  }
  acl = "public-read"
}

resource "aws_s3_bucket_policy" "brinabh_bucket_policy" {
  bucket = aws_s3_bucket.brinabh_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.brinabh_bucket.arn}/*"
    }]
  })
}

resource "aws_s3_bucket" "brinabh-statefile" {
  bucket = "brinabh-statefile"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}