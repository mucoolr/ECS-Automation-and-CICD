let us start with the Dockerfile first.

I am using mac for the assingment that's why i have used `-platform=linux/amd64` in the Dockerfile `FROM` layer.

We have used muli stage Dockerfile , where we first build the image followed by tests and then deploy.
If the tests fail, then the image is not build and so container.

We have wrote the terraform code using modular approach.

Below is the .aws/credentials file where we have configured AWS access key and secret key for QA, STAGE and PROD accounts respectively.

[qa_creds]
aws_access_key_id = QA_AWS_ACCESS_KEY_ID
aws_secret_access_key = QA_AWS_SECRET_ACCESS_KEY

[stage_creds]
aws_access_key_id = STAGE_AWS_ACCESS_KEY_ID
aws_secret_access_key = STAGE_AWS_SECRET_ACCESS_KEY

[prod_creds]
aws_access_key_id = PROD_AWS_ACCESS_KEY_ID
aws_secret_access_key = PROD_AWS_SECRET_ACCESS_KEY

To deploy and containerize the application using terraform ,follow below steps :

First run 
`terraform init`

then 
`terraform plan -var-file="values.tfvars" "-lock=false"  `
to check the resources which will be created after `terraform apply` command

then finally run 
`terraform apply -var-file="values.tfvars" "-lock=false"  `

We have the jenkinsfile also in place to deploy the infrastructure but before using the jenkins pipeline we need to configure it with respect to the AWS account where we will be deploying our infrastructure.


