data "template_file" "userdata_dev" {
  template = file("files/userdata_dev.yml")
  vars = {
    hostname = "dev"
  }
}

resource "local_file" "userdata_dev" {
  content  = data.template_file.userdata_dev.rendered
  filename = "files/generated_userdata_dev.yml"
}

resource "null_resource" "cloud_init_config_file_dev" {
  count = var.vm_count
  connection {
    type     = "ssh"
    user     = "${var.PVE_USER}"
    password = "${var.PVE_PASSWORD}"
    host     = "${var.PVE_HOST}"
  }

  provisioner "file" {
    source      = local_file.userdata_dev.filename
    destination = "/var/lib/vz/snippets/userdata_dev.yml"
  }
}

resource "proxmox_vm_qemu" "nfs" {
  depends_on = [
    null_resource.cloud_init_config_file_dev,
  ]
  name = "nfs"
  desc = "The NFS server"
  vmid = 5000

  agent = 1
  target_node = local.target_node
  clone = local.template_image
  cores = 2
  sockets = 2
  memory = 8192

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

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}

resource "proxmox_vm_qemu" "iot" {
  count = 1
  name = "iot"
  vmid = 5001

  agent = 1
  target_node = local.target_node
  clone = local.template_image
  cores = 2
  sockets = 2
  memory = 6144

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

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}
