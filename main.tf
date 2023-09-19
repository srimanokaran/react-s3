provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = var.aws_region
}   

resource "aws_s3_bucket" "fe_bucket"{
    bucket = "sample-fe-bucket"
    tags = {
        Name = "FE Bucket"
    }
}

resource "aws_s3_bucket_policy" "s3_policy" {
    bucket = aws_s3_bucket.fe_bucket.id
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "S3bucketPolicy"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::467663111381:user/sri"
          ]
        }
        Action = [
          "s3:*"
        ]
        Resource = [
          aws_s3_bucket.fe_bucket.arn,
          "${aws_s3_bucket.fe_bucket.arn}/*"
        ]
      },
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
        ]
        Resource = [
          "${aws_s3_bucket.fe_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "fe_bucket" {
  bucket = aws_s3_bucket.fe_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "fe_bucket_website" {
    bucket = aws_s3_bucket.fe_bucket.id
    index_document {
        suffix = "index.html"
    }
}