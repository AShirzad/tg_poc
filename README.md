Quick and dirty example here. To switch environments:
```shell
sh ./terraform_env.sh init test01 QA
sh ./terraform_env.sh apply test01 QA
```

To create a new one:
```shell
sh ./terraform_env.sh init test02 QA
sh ./terraform_env.sh apply test02 QA
```

If you examine the outputs from the above commands, test01 will have parameters from the QA-test01.tfvars applied, 
but test02 will have QA.tfvars, cascading up to common.tfvars from common. We could pass in any type of config
vars here.

To delete an environment:
```shell
rm 
sh ./terraform_env.sh init test01 QA
sh ./terraform_env.sh destroy test01 QA
```

As a further example in  [this terragrunt config](./infrastructure/db/terragrunt.hcl) we can protect 
modules with:
```hcl
prevent_destroy = coalesce(get_env("ENV_TYPE", ""), "QA") == "prod"
```
