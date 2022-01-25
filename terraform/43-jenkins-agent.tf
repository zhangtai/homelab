resource "proxmox_lxc" "jenkins_agent" {
  target_node  = "pve"
  hostname     = "jenkins-agent"
  vmid         = 4043
  ostemplate   = local.lxc_image
  ostype       = "ubuntu"
  unprivileged = true
  start        = false
  onboot       = true

  ssh_public_keys = file("files/public_keys.txt")

  rootfs {
    storage = "local-lvm"
    size    = "30G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = "192.168.3.1"
    ip     = "192.168.3.43/24"
    ip6    = "auto"
  }
}
