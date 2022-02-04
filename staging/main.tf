# our phased release cloudlet test
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
/* provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "betajam"
} */

# Information is stored in Terraform Cloud
# to import it via a module use:
# 'terraform import module.phased_release.akamai_cloudlets_policy.phased_release <policy_name>'
terraform {
  backend "remote" {
    organization = "grinwis-com"

    workspaces {
      name = "phased-release-new"
    }
  }
}

# let's use our phased release module to create a policy based on module rules file
# this will not activate the policy, it will only create it.
module "phased_release" {
  source              = "../modules/phased-release"
  hostnames           = var.hostnames
  policy_name         = var.policy_name
  group_name          = var.group_name
  to_deta_match_value = var.to_deta_match_value
}

# lookup the cloudlet policy created via our module
data "akamai_cloudlets_policy" "pr_policy" {
  policy_id = module.phased_release.id

  # we need to make sure module.phased_release has done it's job otherwise there will be a version mismatch
  depends_on = [
    module.phased_release
  ]
}

# now activate this policy on staging using latest policy version by default.
resource "akamai_cloudlets_policy_activation" "pr_staging" {
  policy_id             = module.phased_release.id
  network               = "staging"
  version               = var.policy_version == null ? split(":", data.akamai_cloudlets_policy.pr_policy.id)[1] : var.policy_version
  associated_properties = var.hostnames
}
