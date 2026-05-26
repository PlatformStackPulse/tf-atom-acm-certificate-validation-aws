resource "aws_acm_certificate_validation" "this" {
  count = module.this.enabled ? 1 : 0

  certificate_arn         = var.certificate_arn
  validation_record_fqdns = var.validation_record_fqdns
}
