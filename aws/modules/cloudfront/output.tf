output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "distribution_arn" {
  value       = aws_cloudfront_distribution.s3_distribution.arn
  description = "Used for OAC"
}
