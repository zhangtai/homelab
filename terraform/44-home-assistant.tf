resource "proxmox_lxc" "home_assistant" {
  target_node  = "pve"
  hostname     = "homeassistant"
  vmid         = 4044
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  ostype       = "ubuntu"
  unprivileged = true
  start        = false
  onboot       = true

  ssh_public_keys = file("files/public_keys.txt")

  rootfs {
    storage = "local-lvm"
    size    = "20G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = "192.168.3.1"
    ip     = "192.168.3.44/24"
    ip6    = "auto"
  }
}
