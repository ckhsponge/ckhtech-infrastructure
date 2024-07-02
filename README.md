# ckhtech-infrastructure
Terraform scripts written about on https://ckhtech.medium.com

### Prerequisites
You must have [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli), 
Terragrunt and maybe rbenv installled.
I prefer using Homebrew installations.

```shell
brew install terraform
brew install terragrunt
brew install rbenv ruby-build
rbenv install 3.2.2
```

Using a remote backend for Terraform is recommended.
See the below notes for example backends.
Access to the backend and the AWS API can be [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) with profiles.
Use the default profile or a named profile. 
The below examples use S3 for remote state. 
Manually create an S3 bucket and use it in the backend. 

## CKH-TECH
All these great modules live in the repo [ckhsponge/ckhtech-modules](https://github.com/ckhsponge/ckhtech-modules).
This repo is the "live" repo which demonstrates how to deploy the modules using Terragrunt.
Clone this repo and follow the instructions below to get the module live in your environment.

## Resizer
[On Demand Image Resizing with CloudFront, S3 and Lambda in Ruby and Terraform](https://medium.com/@ckhtech/on-demand-image-resizing-with-cloudfront-s3-and-lambda-in-ruby-and-terraform-d9fb06e60b37)

Copy the example files:

```shell
cp resizer_example/terragrunt.hcl.example resizer_example/terragrunt.hcl
```

* Set the name of your state bucket if you are using remote state.
* Choose the host name for your resizing service. 
* Choose the name of the bucket the resizing service will get and save images to.
* Set the domain name which is probably the root of the host name. 
This will be used by Route53 and certificates if you need to set those up.
If you have those already they will be referenced and used.

Deploy it! 
The script will first install some gems that the Ruby code uses in the Lambda.
There's an assumption that you use rbenv to manage Ruby versions.
It then inits the Terraform directory and applies the infrastructure with your approval.

```shell
cd resizer_example

# if you need a route53 zone created:
cd route53 && terragrunt apply

# if you need a certificate for *.mydomain.com:
cd certificate && terragrunt apply

# deploy the resizer!
cd resizer && terragrunt apply
```

After applying the changes there will be an example URL displayed in the output containing example images at the host name you configured earlier.

```shell
% cd resizer && terragrunt apply
...
Apply complete!

Outputs:
...
example_resized_url = "https://resizer.toonsy.net/files/images/possum/default.webp"
example_source_url = "s3://net-toonsy-resizer/source/images/possum/original/cute-animal.jpeg"
```

### Lambda layer and HEIC support
You must add an imagemagick lambda layer for the resizer to function.
Compile the lambda layer yourself to gain HEIC (iPhone) support.
This may take a long time to build.
```shell
mkdir -p install
cd install
git clone https://github.com/provenancetech/imagemagick-aws-lambda-2
# or 
git clone git@github.com:ckhsponge/imagemagick-aws-lambda-2.git
cd imagemagick-aws-lambda-2
# start your docker then:
make all
# ensure AWS credentials are in terminal e.g. export AWS_PROFILE=...
make deploy DEPLOYMENT_BUCKET=<YOUR BUCKET NAME>
```

## Sinworld
Originially presented at Sin City Ruby 2024, 
Sinworld is a cornucopia of Terraform modules centered around a Sinatra web server.
Run a full featured application in an instant! Modules include:

* Sinatra on Lambda
* DynamoDB
* Route53 Zone
* Certificate
* Cloudfront
* S3 buckets for static files and dynamic files
* Image resizer
* URL redirector
* Email sending with SES (coming soon)
* Email server for receiving (coming soon)

### Instructions
First, clone the repo.
```shell
git clone git@github.com:ckhsponge/ckhtech-infrastructure.git
cd ckhtech-infrastructure/sinworld
cp infrastructure/terragrunt.hcl.example infrastructure/terragrunt.hcl
```
Edit infrastructure/terragrunt.hcl
* Rename the terraform config.state bucket e.g jimmys-terraform-state
* Rename the config.key in case you re-use the sinworld module
* Update domain_base. This is probably the Route53 Zone and certificate domain name e.g. mydomain.com

```shell
cp infrastructure/main/terragrunt.hcl.example infrastructure/main/terragrunt.hcl
```
Edit infrastructure/main/terragrunt.hcl
* Specify the host_name for your service e.g. www.mydomain.com
* Choose which services to create alongside the web server

If you need a Route53 Zone run this first:
```shell
bin/infrastructure.sh route53
```
Copy the name servers in the output to your registrar.

Deploy it all!
```shell
bin/infrastructure.sh
```

If all goes well, there are some commands in the output.
Open the URL and you should see "Hello, Sinworld!"

Run the put-public command to copy static files to S3
```shell
# e.g. aws s3 sync app/public/ s3://com-mydomain-www-static/dist/
```

Download gems:
```shell
bin/gems.sh
```

Publish a code update for your lambda.
Most likely your lambda function name is correct. If not, check your publish_command in the output.
```shell
bin/publish.sh
```

Reload your URL and you will now see the sin tracker app.

You can now modify the code in the app/ directory to create your own project.


### Un-deploy
Once you are done, destroy the resources. 
Or leave it running for just a few pennies a day.
```shell
bin/infrastructure.sh main destroy
```
If you created a Route53 Zone destroy with:
```shell
bin/infrastructure.sh route53 destroy
```

