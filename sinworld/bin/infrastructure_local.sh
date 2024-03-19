# apply terraform changes using a local directory instead of pulling from github
cd infrastructure/main
terragrunt init --terragrunt-source ../../../../ckhtech-modules//sinworld
terragrunt apply --terragrunt-source ../../../../ckhtech-modules//sinworld
