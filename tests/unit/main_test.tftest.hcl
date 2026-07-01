# Unit Tests for tf-atom-acm-certificate-validation-aws
#
# These tests use a mock AWS provider — no real AWS calls are made and no
# credentials are required. They assert only on values that are KNOWN at plan
# time (tf-label id, the enabled flag) — never on computed ACM arns/ids, which
# are unknown under a mock provider.
#
# Run with:      terraform test -test-directory=tests/unit
# Run verbose:   terraform test -test-directory=tests/unit -verbose
# Run one test:  terraform test -test-directory=tests/unit -run "creates_when_enabled"

mock_provider "aws" {}

# Standard tf-label inputs shared by every run block below.
variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
}

# ---------------------------------------------------------------------------
# Test: module is enabled by default and exposes a stable, plan-known id
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default when enabled is not overridden."
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be composed as namespace-stage-name (eg-test-thing)."
  }
}

# ---------------------------------------------------------------------------
# Test: module reports disabled and creates nothing when enabled = false
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when enabled is set to false."
  }
}
