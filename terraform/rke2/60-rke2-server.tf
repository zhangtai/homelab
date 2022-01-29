data "template_file" "userdata_rke2_server" {
  template = file("files/userdata_rke2_server.yml")
  vars = {
    hostname = "rke2-server"
  }
}

resource "local_file" "userdata_rke2_server" {
  content  = data.template_file.userdata_rke2_server.rendered
  filename = "/var/lib/vz/snippets/userdata_rke2_server.yml"
}

resource "proxmox_vm_qemu" "rke2_server" {
  depends_on = [
    local_file.userdata_rke2_server,
  ]
  name = "rke2-server"
  desc = "The rke2 server"
  vmid = 6060
  onboot = true

  agent = 1
  target_node = local.target_node
  clone = local.template_image
  cores = 2
  sockets = 1
  memory = 2048

  bootdisk = "scsi0"
  boot = "c"

  disk {
    size = "60G"
    type = "virtio"
    storage = local.disk_store
    discard = "on"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.3.60/24,gw=192.168.3.1"
  cicustom = "user=local:snippets/userdata_rke2_server.yml"
  cloudinit_cdrom_storage = "local-lvm"
  lifecycle {
    ignore_changes = [
      id,
      name,
      disk,
      network
    ]
  }
}
