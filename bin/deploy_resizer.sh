cd terraform/modules/resizer
rbenv exec bundle config set --local path 'app/vendor/bundle'
rbenv exec bundle install
cd ../../deploy/resizer
terraform init
terraform apply
