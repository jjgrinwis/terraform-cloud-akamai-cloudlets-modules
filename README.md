# Akamai Terraform Cloud Cloudlet examples #

some example code on how to use the Phased Release cloudlet with Terraform Cloud with a single policy.
In the staging environment you create your policies and push to staging. When activate on staging you can run tests to make sure policy is behaving like expected.
There is a separate production workspace that will use information from staging and push to Akamai production so your tested policy is pushed to Akamai production.

Depending on your setup you can use VCS connection or use a remote instance on Terraform Cloud. Some variables are shared between staging and production and each workspace has it's own .tfvars file for workspace specific settings like version number to activate for example.

![image](https://user-images.githubusercontent.com/3455889/152566848-8c9071e8-1185-4c0e-abff-b8521a5f592b.png)
