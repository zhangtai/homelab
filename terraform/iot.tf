data "template_file" "userdata_iot" {
  template = file("files/userdata_iot.yml")
  vars = {
    hostname = "iot"
  }
}

resource "local_file" "userdata_iot" {
  content  = data.template_file.userdata_iot.rendered
  filename = "/var/lib/vz/snippets/userdata_iot.yml"
}

resource "proxmox_vm_qemu" "iot" {
  depends_on = [
    local_file.userdata_iot,
  ]
  name = "iot"
  desc = "The IoT server"
  vmid = 5001
  onboot = true

  agent = 1
  target_node = local.target_node
  clone = local.template_image
  cores = 2
  sockets = 1
  memory = 4096

  bootdisk = "scsi0"
  boot = "c"

  disk {
    size = "60G"
    type = "virtio"
    storage = local.disk_store
    discard = "on"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.3.51/24,gw=192.168.3.1"
  cicustom = "user=local:snippets/userdata_iot.yml"
  cloudinit_cdrom_storage = "local-lvm"
  lifecycle {
    ignore_changes = [
      id,
      name,
      disk
    ]
  }
}
