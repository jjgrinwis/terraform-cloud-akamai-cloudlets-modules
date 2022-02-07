# our phased release cloudlet test
terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "1.10.0"
    }
  }
}

# we use information from our staging setup but we only need the policy id and optionally the latest version
# make sure to share the output vars from this workspace with other workspace(s)
data "tfe_outputs" "policy" {
  organization = "grinwis-com"
  workspace    = "phased-release-cloudlet"
}

# now activate this policy on staging using latest policy version by default.
resource "akamai_cloudlets_policy_activation" "pr_staging" {
  policy_id             = data.tfe_outputs.policy.values["id"]
  network               = "staging"
  version               = var.policy_version == null ? split(":", data.akamai_cloudlets_policy.pr_policy.id)[1] : var.policy_version
  associated_properties = var.hostnames
}
