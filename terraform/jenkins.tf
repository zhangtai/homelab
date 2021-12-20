resource "proxmox_lxc" "jenkins" {
  target_node  = "pve"
  hostname     = "jenkins"
  vmid         = 4003
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  ostype       = "ubuntu"
  unprivileged = true
  start        = true
  onboot       = true

  ssh_public_keys = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXiMs/CDEjPX7djACcECWL9zTbNTGyhto5nHMW15kTMzyjTgPETRdSD1Xh+Y1lj4IDsvUZK3Wr6gBjA5kFIldcqB7WtyESWm2hOk1yOhmTJUqeRjdIZB4yWd8YJxLqQxwD0Rglay+fq0LFGm/TaXvgAHl0HctkRmd+yXV6nru1vO0q6k2ASkAn18KC8SPXgZrDzx9jjA9sfyuYb7B+OHCL/o0WJ/7i+pIVYOBoE3ucjReRznY0E/P22IB+owtwq1E0XENjmzgSKNfmZC38n5uFmOGJDfJFTJhHMzEi/15ym+rWSy4BjjOxV4WIE1b9u/OPdgf8HvfpOcaI1X5KK7t7l4aSYFj2pInAu0gfwC51ImaEflc2GuWWrLGUrwp9eYHEazv++SedP5aCR9qm65fcxsbCyACCYWbAOpxcmUb9D5wMR9A17aDJFO6Yk6/5LLGlm/s1J2b96X8m4y0vNpi8vI6W+KrnUaDazj2UMbtathQsciNIMM9udrUZnE5XLm9JI+rW+8qkc+aXwmSQY0xSREtRgDDfF8828eeeibX+PlA1lbZixbPKp6NyPY7Rw3YszSwr259fB1Ib9aCEqNN+bJlhu/fJm71VHFaMCa6gUCqpu9c3+vcI1qkFkCw3W0IifMVNlI50DDtXN8abwRGziENx913bzZPjhjmN3GIkYQ== taizhang@Tais-MBP.lan
  EOT

  memory       = 4096

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
