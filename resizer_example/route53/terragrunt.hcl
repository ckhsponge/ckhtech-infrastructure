include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "git@github.com:ckhspone/ckhtech-modules.git//route53"
}
inputs = {
  #  domain_name = ""
}
