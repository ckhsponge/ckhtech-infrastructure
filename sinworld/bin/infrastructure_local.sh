# apply terraform changes using a local directory instead of pulling from github
MODULE=${1:-main}
ACTION=${2:-apply}
cd infrastructure/$MODULE
terragrunt init --terragrunt-source ../../../../ckhtech-modules//$MODULE
terragrunt $ACTION --terragrunt-source ../../../../ckhtech-modules//$MODULE
