resource "proxmox_lxc" "jenkins_controller" {
  target_node  = "pve"
  hostname     = "jenkins-controller"
  vmid         = 4042
  ostemplate   = local.lxc_image
  ostype       = "ubuntu"
  unprivileged = true
  start        = true
  onboot       = true

  ssh_public_keys = file("files/public_keys.txt")

  memory       = 4096

  rootfs {
    storage = "local-lvm"
    size    = "30G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = "192.168.3.1"
    ip     = "192.168.3.42/24"
    ip6    = "auto"
  }
}
