# return our policy id
output "id" {
  value = resource.akamai_cloudlets_policy.phased_release.id
}

output "latest_version" {
  value = resource.akamai_cloudlets_policy.phased_release.version
}


