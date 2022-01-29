resource "proxmox_lxc" "home_assistant" {
  target_node  = "pve"
  hostname     = "home-assistant"
  vmid         = 4044
  ostemplate   = local.lxc_image
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
