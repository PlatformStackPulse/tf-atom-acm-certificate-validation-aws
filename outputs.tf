output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "certificate_arn" {
  description = "ARN of the validated certificate"
  value       = try(aws_acm_certificate_validation.this[0].certificate_arn, null)
}
