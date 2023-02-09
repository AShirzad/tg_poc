if [ $# -lt 2 ]; then
  echo "Usage: terraform_env.sh command environment_name [environment_type]"
  echo "Where environment_type defaults to QA"
  exit 1
fi

ENV_TYPE=$3 ENV_NAME=$2 terragrunt run-all $1 --terragrunt-config ./infrastructure/terragrunt.hcl --terragrunt-non-interactive
