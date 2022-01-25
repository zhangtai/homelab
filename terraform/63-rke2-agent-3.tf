data "template_file" "userdata_rke2_agent_3" {
  template = file("files/userdata_rke2_agent.yml")
  vars = {
    hostname = "rke2-agent-3"
  }
}

resource "local_file" "userdata_rke2_agent_3" {
  content  = data.template_file.userdata_rke2_agent_3.rendered
  filename = "/var/lib/vz/snippets/userdata_rke2_agent_3.yml"
}

resource "proxmox_vm_qemu" "rke2_agent_3" {
  depends_on = [
    local_file.userdata_rke2_agent_3,
  ]
  name = "rke2-agent-3"
  desc = "The rke2 agent"
  vmid = 6063
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
  ipconfig0 = "ip=192.168.3.63/24,gw=192.168.3.1"
  cicustom = "user=local:snippets/userdata_rke2_agent_3.yml"
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
