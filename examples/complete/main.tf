# -----------------------------------------------------------------------------
# Complete example: tf-atom-acm-certificate-validation-aws
#
# Typically consumed alongside tf-atom-acm-certificate-aws and DNS records
# created for the certificate's domain_validation_options.
# -----------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

module "acm_certificate_validation" {
  source = "../../"

  namespace   = "eg"
  environment = "use1"
  stage       = "app"
  name        = "web"

  certificate_arn         = "arn:aws:acm:us-east-1:123456789012:certificate/abc-123"
  validation_record_fqdns = ["_abc123.app.example.com"]
}

output "validation_id" {
  description = "Id of the certificate validation."
  value       = module.acm_certificate_validation.id
}
