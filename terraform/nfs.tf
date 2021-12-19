data "template_file" "userdata_nfs" {
  template = file("files/userdata_nfs.yml")
  vars = {
    hostname = "nfs"
  }
}

resource "local_file" "userdata_nfs" {
  content  = data.template_file.userdata_nfs.rendered
  filename = "/var/lib/vz/snippets/userdata_nfs.yml"
}

resource "proxmox_vm_qemu" "nfs" {
  depends_on = [
    local_file.userdata_nfs,
  ]
  name = "nfs"
  desc = "The NFS server"
  vmid = 5000
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
    size = "100G"
    type = "virtio"
    storage = local.disk_store
    discard = "on"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.3.50/24,gw=192.168.3.1"
  cicustom = "user=local:snippets/userdata_nfs.yml"
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
