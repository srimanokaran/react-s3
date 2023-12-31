output "website_domain" {
    value = aws_s3_bucket.fe_bucket.website_domain
}

output "website_endpoint" {
    value = aws_s3_bucket.fe_bucket.website_endpoint
}

output "arn" {
    value = aws_s3_bucket.fe_bucket.arn
}