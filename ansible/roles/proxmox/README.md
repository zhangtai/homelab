# Setup proxmox

This playbook will run after a fresh proxmox server installed, it will:

- Remove enterprise repo list
- Install basic tools
- Create ssh key
- Create template based on Ubuntu cloud image

## Provisioning the server

- Ensure pubkey for ssh setup

`ansible-playbook site.yaml`
