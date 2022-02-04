# Akamai Terraform Cloud Cloudlet examples #

some example code on how to use the Phased Release cloudlet with Terraform Cloud.
In the staging environment you create your policies and push to staging. There is a separate production workspace that will use information from staging and push to production. You have to option to select a specific version when pushing to production.

Staging is being triggered by GitHub push. Production you can use local 'terraform apply' but will use Terraform cloud to store state.
