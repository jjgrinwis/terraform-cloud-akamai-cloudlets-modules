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
provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "betajam"
}

# we're storing the state in terraform cloud
# when using existing resource first import it using 'terraform import akamai_cloudlets_policy.phased_release <cl_policy_name>'
# https://support.hashicorp.com/hc/en-us/articles/360061289934-How-to-Import-Resources-into-a-Remote-State-Managed-by-Terraform-Cloud
# you need to define the remote backend and make sure to select correct workspace ;-)
# when running in Terraform Cloud you don't need this section anymore
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
}

# now activate this policy on staging using latest policy version by default.
resource "akamai_cloudlets_policy_activation" "pr_staging" {
  policy_id = module.phased_release.id
  network   = "staging"
  version   = var.policy_version == null ? split(":", data.akamai_cloudlets_policy.pr_policy.id)[1] : var.policy_version
  # version               = resource.akamai_cloudlets_policy.phased_release.version
  associated_properties = var.hostnames
}
