# -----------------------------------------------------------------------------
# tf-atom-acm-certificate-validation-aws
#
# Single-resource atom: one aws_acm_certificate_validation, gated by the
# standard `enabled` flag from context.tf. This resource has no tags.
# -----------------------------------------------------------------------------

resource "aws_acm_certificate_validation" "this" {
  count = local.enabled ? 1 : 0

  certificate_arn         = var.certificate_arn
  validation_record_fqdns = var.validation_record_fqdns
}
