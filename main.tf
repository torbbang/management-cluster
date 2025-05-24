/*
Kubernetes management cluster for cluster API managed kubernetes clusters in proxmox.
*/


resource "proxmox_virtual_environment_vm" "node" {
  node_name = var.vm.node
  name      = var.node.hostname

  agent {
    enabled = true
  }

  cpu {
    cores        = var.vm.cpu_cores
    type         = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.vm.memory_mb
    floating  = var.vm.memory_mb
  }

  disk {
    datastore_id = var.vm.disk_datastore
    size         = var.vm.disk_size
    interface    = "scsi0"
    file_id      = proxmox_virtual_environment_download_file.talos_iso.id
  }

  network_device {
    bridge = var.vm.bridge
    vlan_id = var.vm.vlan
  }

  operating_system {
    type = "l26"
  }

  tpm_state {
    version = "v2.0"
  }

  initialization {
    interface = "ide2"
    dns {
      servers = var.node.nameservers
    }
    ip_config {
      ipv4 {
        gateway = var.node.gateway
        address = var.node.cidr_address
      }
    }
  }
  lifecycle {
    prevent_destroy = false
  }
}
