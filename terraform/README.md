# Terraform to init homelab servers

Firstly need setup Doppler, refer to [Doppler setup](../README.md).

```shell
cd terraform
terraform init
doppler run --command='terraform apply'
```
