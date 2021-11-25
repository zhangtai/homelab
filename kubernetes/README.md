# RKE

```shell
rke up
export KUBECONFIG="${HOMELAB}/kubernetes/kube_config_cluster.yml"

kubectl get services -A

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```
