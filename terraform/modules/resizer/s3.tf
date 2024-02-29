module files_bucket_cloudfront_attach {
  count = length(aws_cloudfront_distribution.main)
  source = "../../resources/s3_cloudfront_attach"
  bucket_name = data.aws_s3_bucket.files.bucket
  bucket_arn = data.aws_s3_bucket.files.arn
  cloudfront_distribution_arn = aws_cloudfront_distribution.main[0].arn
  encrypt_bucket = false // KMS keys cost $1/month
}
