# output the created policy id
output "policy_id" {
  value = module.phased_release.id
}

output "active_version" {
  value = resource.akamai_cloudlets_policy_activation.pr_staging.version
}
