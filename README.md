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
