mock_provider "aws" {}

# Standard tf-label inputs shared by every run block below.
variables {
  namespace       = "eg"
  stage           = "test"
  name            = "thing"
  certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abc-123"
}

run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled = true when enabled is left at its default."
  }

  assert {
    condition     = length(aws_acm_certificate_validation.this) == 1
    error_message = "Exactly one aws_acm_certificate_validation should be planned when enabled."
  }
}

run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when enabled = false is passed."
  }

  assert {
    condition     = length(aws_acm_certificate_validation.this) == 0
    error_message = "No aws_acm_certificate_validation should be planned when disabled."
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled."
  }
}
