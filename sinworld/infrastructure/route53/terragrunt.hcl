include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "git@github.com:ckhsponge/ckhtech-modules.git//route53?ref=v1.3"
}
inputs = {
  #  domain_base = ""
}
