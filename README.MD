### Introduction
This repo will show how to use terraform to create resources for devcloud demo.

### Install Terraform
Terraform is distributed as a single binary. Download a Terraform package and decompress it to a directory included in your system's PATH. 
1. Download the package from the [Terraform home page](https://developer.hashicorp.com/terraform/downloads) 
2. Decompress the package and add the directory where the package is located to the system's PATH.
   * [Config PATH in Linux](https://stackoverflow.com/questions/14637979/how-to-permanently-set-path-on-linux-unix?spm=a2c4g.11186623.0.0.51777aa7jeVdin)
   * [Config PATH in Windows](https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows?spm=a2c4g.11186623.0.0.51777aa7jeVdin)
3. Run the following command in the command-line interface (CLI) to check whether the path is correctly configured:
```
terraform
```
If the following information is displayed, the configuration is correct and Terraform is ready to run.
>Usage: terraform [-version] [-help] <command> [args]
>
>....

### Configuration
1. Download the project to the environment where terraform is installed.
2. (Optional)Config the __"main.tf"__ file in the root directory, comment out the modules you don't want to create. Each "module" block in the main file will create the resources in the module directory. For example, the "network_service" module will create the VPC defined in the "./module/VPC". 
3. Config the __"demo.tfvars"__ file. Make sure the **AKSK**(the "access_key" and "secret_key") has been configured. [How to get AKSK](https://support.huaweicloud.com/intl/en-us/usermanual-iam/iam_02_0003.html).
4. You can adjust the configuration according to your needs. Please refer to the [HUAWEI Cloud registry](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs
) to get more details about how to config the services of HUAWEI Cloud.



### How to run 
Enter the root directory of the project and type in the following commands in command-line interface (CLI)
```
terraform init
terraform plan -var-file="demo.tfvars"
terraform apply -var-file="demo.tfvars"
```

Clean up resources after the operation is complete.
```
terraform destroy -var-file="demo.tfvars"
```


### [Reference](https://support.huaweicloud.com/intl/zh-cn/qs-terraform/index.html)

