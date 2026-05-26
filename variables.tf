variable "certificate_arn" {
  description = "ARN of the ACM certificate to validate"
  type        = string
  validation {
    condition     = can(regex("^arn:aws:acm:", var.certificate_arn))
    error_message = "certificate_arn must be a valid ACM certificate ARN."
  }
}

variable "validation_record_fqdns" {
  description = "List of FQDNs of the DNS validation records"
  type        = list(string)
  default     = null
}
