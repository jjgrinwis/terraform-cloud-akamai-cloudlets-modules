# Terraform module to just activate on Akamai production
This Terraform script will use information from staging environment and activate on Akamai production
We will share state information via Terraform cloud but only the id and latest version
You can overwrite that version by specifying it in the terraform.prod.auto.tfvars file.