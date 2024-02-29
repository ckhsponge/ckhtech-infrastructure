# ckhtech-infrastructure
Terraform scripts written about on https://ckhtech.medium.com

### Prerequisites
You must have [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installled.
I prefer using the Homebrew installation.

Using a remote backend for Terraform is recommended.
See the below notes for example backends.
Access to the backend and the AWS API can be [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) with profiles.
Use the default profile or a named profile. 
The below examples use S3 for remote state. 
Manually create an S3 bucket and use it in the backend. 

## Resizer
[On Demand Image Resizing with CloudFront, S3 and Lambda in Ruby and Terraform](https://medium.com/@ckhtech/on-demand-image-resizing-with-cloudfront-s3-and-lambda-in-ruby-and-terraform-d9fb06e60b37)
Copy some example files:

```shell
cp terraform/deploy/resizer/backend.tf.example terraform/deploy/resizer/backend.tf
cp terraform/deploy/resizer/terraform.tfvars.example terraform/deploy/resizer/terraform.tfvars
```

In the backend you must at least use the name of your state bucket if you are using remote state.
In the tfvars you must choose a host name for your resizing service. 
You can optionally create a Route 53 zone and certificate if you haven't created those for your domain yet.
If you have those already they will be referenced and used.

Deploy it! 
The script will first install some gems that the Ruby code uses in the Lambda.
There's an assumption that you use rbenv to manage Ruby versions.
It then inits the Terraform directory and applies the infrastructure with your approval.

```shell
bin/deploy_resizer.sh
```

After applying the changes there will be example URLs displayed in the output containing example images at the host name you configured earlier.
