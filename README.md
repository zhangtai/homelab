# homelab

My Homelab, with some provisioning files...

## Setup Doppler

```sh
# Ubuntu
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo apt-key add -
echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list
sudo apt-get update && sudo apt-get install doppler

# Mac
brew install dopplerhq/cli/doppler

# Setup
doppler login
cd ~/GitHub/homelab && doppler setup
```

## Proxmox server

1. `cd ansible && doppler run --command='ansible-playbook proxmox.yml'`: Install basic tools on pve, download Ubuntu cloudimg file and create basic template
1. Manual copy the generated ssh pubkey to GitHub
1. `doppler run --command='ansible-playbook proxmox.yml'`: To install dotfiles

Go to [terraform](./terraform/README.md) for provisioning servers in Proxmox

### VM servers

```shell
cd ansible
doppler run --command='ansible-playbook homelab.yml --tags=postgresql'
```

### RKE2

https://docs.rke2.io/install/quickstart/

#### Server

```shell
curl -sfL https://get.rke2.io | sudo https_proxy=http://192.168.3.1:8889 sh -
sudo cat /var/lib/rancher/rke2/server/node-token

sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
journalctl -u rke2-server -f
```

#### Agent

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

#### Access

https://docs.rke2.io/cluster_access/
