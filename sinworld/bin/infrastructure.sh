# apply terraform changes by pulling from github
MODULE=${1:-main}
ACTION=${2:-apply}
cd infrastructure/$MODULE
terragrunt $ACTION
