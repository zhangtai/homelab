# Prometheus

```shell
k create ns monitoring
helm upgrade -i prometheus prometheus-community/kube-prometheus-stack -f values.yml -n monitoring
helm uninstall prometheus -n monitoring
```

```shell
helm upgrade -i prometheus prometheus-community/prometheus -f prometheus_values.yml -n monitoring
```
