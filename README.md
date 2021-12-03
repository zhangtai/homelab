# homelab

My Homelab, with some provisioning files...

## Quick steps

1. `cd ansible && ansible-playbook proxmox.yml`: Install basic tools on pve, download Ubuntu cloudimg file and create basic template

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

## Proxmox

```shell
ansible-playbook proxmox.yml
```

### VM servers

```shell
cd terraform/rke
tf init
doppler run --command='terraform apply'
doppler run --command='ansible-playbook dev-server.yml'
```

## Kubernetes

### Setup nodes

```shell
cd terraform/rke
tf init
doppler run --command='terraform apply'
```

### Setup cluster

```shell
cd kubernetes
```