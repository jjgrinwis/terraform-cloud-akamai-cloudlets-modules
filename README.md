# Akamai Terraform Cloud Phased Release Cloudlet example #

Some example Terraform code on how to use the Akamai Phased Release Cloudlet with Terraform Cloud with a single policy shared between staging and production.
In the staging environment you create your policy with the rules and it push to Akamai staging. When active on staging you can run tests to make sure policy is behaving like expected. There is a separate production workspace that will use information from staging so you can first test on Akamai Staging after which the same policy will be pushed to Akamai Production.

Depending on your setup you can use VCS connection or use a remote instance on Terraform Cloud. Some variables are shared between staging and production and each workspace has it's own .tfvars file for workspace specific settings like version number to activate for example.

![image](https://user-images.githubusercontent.com/3455889/152566848-8c9071e8-1185-4c0e-abff-b8521a5f592b.png)
