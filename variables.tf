variable "hostnames" {
  description = "One or more hostnames that's using this cloudlet"
  type        = list(string)
  validation {
    condition     = length(var.hostnames) > 0
    error_message = "At least one hostname should be provided, it can't be empty."
  }
}

variable "policy_name" {
  description = "The Phased Release cloudlet policy name"
  type        = string
}

variable "group_name" {
  description = "Akamai group to create this resource in"
  type        = string
}

variable "to_deta_match_value" {
  description = "match value of all items that need to go to deta"
  type        = string
}

variable "description" {
  description = "Specific name for this policy version"
  type        = string
  default     = "Terraform updated rules"
}

variable "policy_version" {
  description = "By default latest version will be used, can be overwritten using this variable"
  type        = number
  default     = null
}

variable "workspace" {
  description = "Terraform cloud workspace to use"
  type        = string
  default     = "phase-release-cloudlet"
}
