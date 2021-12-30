terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://localhost:8006/api2/json"
  pm_tls_insecure = true
}

variable "PVE_USER" {
  type = string
}
variable "PVE_PASSWORD" {
  type = string
}
variable "PVE_HOST" {
  type = string
}

locals {
  disk_store = "local-lvm"
  target_node = "pve"
  template_image = "ubuntu-2004-stage1-v2"
  lxc_image = "local:vztmpl/ubuntu-20211230-2.tar.xz"
}
