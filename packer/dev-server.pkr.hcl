packer {
  required_plugins {
    proxmox = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_url" {
    type = string
    default = "https://192.168.3.5:8006/api2/json"
}

variable "proxmox_username" {
    type = string
    default = "root@pam"
}

variable "proxmox_password" {
    type = string
}

source "proxmox-clone" "dev-server" {
    proxmox_url = "${var.proxmox_url}"
    username = "${var.proxmox_username}"
    password = "${var.proxmox_password}"
    ssh_username = "ubuntu"
    ssh_private_key_file = "/home/tai/.ssh/id_rsa"
    node = "pve"
    insecure_skip_tls_verify = true
    clone_vm = "cloudimg-qemu-agent"
    template_name = "dev-server-21.11.1"
    os = "l26"
    cores = 2
    sockets = 1
    memory = 2048
    scsi_controller = "virtio-scsi-pci"
    cpu_type = "host"
}

build {
    sources = ["source.proxmox-clone.dev-server"]

    provisioner "shell" {
        inline = ["echo Hello world!"]
    }
}
