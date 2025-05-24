terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.74.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.8.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.pve.url
  api_token = "${var.pve.token_id}=${var.pve.token_value}"
  insecure = true
  ssh {
    agent = false
    username = var.pve.ssh_user
    private_key = file(var.pve.ssh_key)
  }
}
