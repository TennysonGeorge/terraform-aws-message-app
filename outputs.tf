output "api_gateway_endpoint" {
  value = aws_api_gateway_deployment.api_deployment.invoke_url
}

output "s3_bucket_url" {
  value = aws_s3_bucket.message_app_bucket.bucket_regional_domain_name
}




