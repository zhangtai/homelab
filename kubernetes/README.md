# RKE2

https://docs.rke2.io/install/quickstart/

## Server

```shell
curl -sfL https://get.rke2.io | sudo https_proxy=http://192.168.3.1:8889 sh -
sudo cat /var/lib/rancher/rke2/server/node-token

sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
journalctl -u rke2-server -f
```

## Agent

```shell
curl -sfL https://get.rke2.io | sudo https_proxy=http://192.168.3.1:8889 INSTALL_RKE2_TYPE="agent" sh -
sudo systemctl enable rke2-agent.service
sudo mkdir -p /etc/rancher/rke2/
sudo bash -c 'cat > /etc/rancher/rke2/config.yaml <<EOF
server: https://192.168.3.60:9345
token: <token from server node>
EOF'
sudo systemctl start rke2-agent.service
```

https://docs.rke2.io/advanced/#configuring-an-http-proxy

```shell /etc/default/rke2-agent
CONTAINERD_HTTP_PROXY=http://192.168.3.1:8889
CONTAINERD_HTTPS_PROXY=http://192.168.3.1:8889
CONTAINERD_NO_PROXY=127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.svc,.cluster.local
```

## Access

https://docs.rke2.io/cluster_access/

## Longhorn

