data "template_file" "userdata_rke2_agent_1" {
  template = file("files/userdata_rke2_agent.yml")
  vars = {
    hostname = "rke2-agent-1"
  }
}

resource "local_file" "userdata_rke2_agent_1" {
  content  = data.template_file.userdata_rke2_agent_1.rendered
  filename = "/var/lib/vz/snippets/userdata_rke2_agent.yml"
}

resource "proxmox_vm_qemu" "rke2_agent_1" {
  depends_on = [
    local_file.userdata_rke2_agent_1,
  ]
  name = "nfs"
  desc = "The rke2 agent"
  vmid = 6061
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
  ipconfig0 = "ip=192.168.3.61/24,gw=192.168.3.1"
  cicustom = "user=local:snippets/userdata_rke2_agent.yml"
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
