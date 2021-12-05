# Ansible

## Homelab services

```shell
doppler run --command='ansible-playbook site.yml \
  -e "MINIO_USER=${MINIO_ROOT_USER} MINIO_PASS=${MINIO_ROOT_PASSWORD}"'
```