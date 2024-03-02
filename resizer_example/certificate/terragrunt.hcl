include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "git@github.com:ckhspone/ckhtech-modules.git//certificate"
}
inputs = {
  #  domain_name = ""
}
