output "cloudfront_distribution_arn" {
  value = var.skip_cloudfront ? "" : aws_cloudfront_distribution.main[0].arn
}

output lambda_invoke_url {
  value = aws_apigatewayv2_stage.lambda.invoke_url
}

output lambda_invoke_domain_name {
  value = replace(replace(aws_apigatewayv2_stage.lambda.invoke_url,"https://",""),"/","")
}

output original_directory {
  value = var.original_directory
}

output source_directory {
  value = var.source_directory
}

output destination_directory {
  value = var.destination_directory
}

output host_name {
  value = var.host_name
}

output files_bucket {
  value = data.aws_s3_bucket.files.bucket
}
