# Akamai Terraform Cloud Cloudlet examples #

some example code on how to use the Phased Release cloudlet with Terraform Cloud.
In the staging environment you create your policies and push to staging. There is a separate production workspace that will use information from staging and push to production. You have to option to select a specific version when pushing to production.

Depending on your setup you can use VCS connection or use a remote instance on Terraform Cloud. Some variables are shared between staging and production and each workspace has it's own .tfvars file for workspace specific settings like version number to activate for example.

![image](https://user-images.githubusercontent.com/3455889/152566848-8c9071e8-1185-4c0e-abff-b8521a5f592b.png)
