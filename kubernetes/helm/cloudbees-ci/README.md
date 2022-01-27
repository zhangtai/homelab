# Cloudbees CI

```shell
k create ns cbci
helm install cbci cloudbees/cloudbees-core -f values.yml -n cbci
helm uninstall cbci -n cbci
```