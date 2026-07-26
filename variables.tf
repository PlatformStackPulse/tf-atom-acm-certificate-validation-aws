# -----------------------------------------------------------------------------
# Module-Specific Variables
#
# Note: Standard labeling variables (enabled, namespace, tenant, environment,
# stage, name, delimiter, attributes, tags, label_order, etc.) are provided
# by context.tf via the tf-label module.
# -----------------------------------------------------------------------------

variable "certificate_arn" {
  description = "ARN of the ACM certificate to validate."
  type        = string

  validation {
    condition     = length(var.certificate_arn) > 0
    error_message = "certificate_arn must be a non-empty string."
  }
}

variable "validation_record_fqdns" {
  description = "List of FQDNs that implement the validation (DNS records). Null lets ACM manage EMAIL validation."
  type        = list(string)
  default     = null
}
