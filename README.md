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

1. `cd ansible && ansible-playbook proxmox.yml`: Install basic tools on pve, download Ubuntu cloudimg file and create basic template
1. Manual copy the generated ssh pubkey to GitHub
1. `ansible-playbook proxmox.yml`: To install dotfiles

Go to [terraform](./terraform/README.md) for provisioning servers in Proxmox

### VM servers

```shell
cd terraform/rke
tf init
doppler run --command='terraform apply'
doppler run --command='ansible-playbook dev-server.yml'
```
