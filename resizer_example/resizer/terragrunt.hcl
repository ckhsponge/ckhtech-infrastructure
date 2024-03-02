include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "git@github.com:ckhsponge/ckhtech-modules.git//resizer"
  before_hook "before_hook_1" {
    commands = ["apply"]
    execute  = ["rbenv", "exec", "bundle", "config", "set", "--local", "path", "app/vendor/bundle"]
  }

  before_hook "before_hook_2" {
    commands = ["apply"]
    execute  = ["rbenv", "exec", "bundle", "install"]
  }
}
inputs = {
  # see parent config
#  host_name = ""
#  files_bucket = ""
}
