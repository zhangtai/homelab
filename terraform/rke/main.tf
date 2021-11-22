terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.3.5:8006/api2/json"
  pm_tls_insecure = true
}

locals {
  disk_store = "local-lvm"
  target_node = "pve"
  template_image = "ubuntu-2004-stage1-v2"
}

resource "proxmox_vm_qemu" "rancher-node" {
  count = var.node_count
  name = "rancher-node-${count.index + 1}"
  vmid = "13${count.index + 1}"

  agent = 1
  target_node = local.target_node
  clone = local.template_image
  cores = 2
  sockets = 2
  memory = 6144

  bootdisk = "scsi0"
  boot = "c"

  disk {
    size = "100G"
    type = "virtio"
    storage = local.disk_store
    discard = "on"
  }

  os_type = "cloud-init"

  ipconfig0 = "ip=192.168.3.3${count.index + 1}/24,gw=192.168.3.1"
}
