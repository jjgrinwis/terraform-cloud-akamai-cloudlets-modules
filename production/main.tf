terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "1.10.0"
    }
  }
}

# for cloud usage these vars have been defined in terraform cloud as a set
# we only need to use this when importing existing resources
/*provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "betajam"
}*/

# Information is stored in Terraform Cloud
# to import it via a module use:
# 'terraform import module.phased_release.akamai_cloudlets_policy.phased_release <policy_name>'
terraform {
  backend "remote" {
    organization = "grinwis-com"

    workspaces {
      name = "phased-release-prod"
    }
  }
}

# we use information from our staging setup but we only need the policy id and optionally the latest version
data "tfe_outputs" "staging" {
  organization = "grinwis-com"
  workspace    = "phased-release-new"
}

# now activate this policy on production using latest policy version by default.
resource "akamai_cloudlets_policy_activation" "pr_production" {
  policy_id = nonsensitive(data.tfe_outputs.staging.values["policy_id"])
  network   = "production"
  version   = var.policy_version == null ? nonsensitive(data.tfe_outputs.staging.values["active_version"]) : var.policy_version
  # version               = resource.akamai_cloudlets_policy.phased_release.version
  associated_properties = var.hostnames
}
