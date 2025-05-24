variable "cluster" {
  type = object ({
    name = string
    endpoint = string
    k8s_version = string
    talos_version = string
  })
}

variable "node" {
  type = object ({
    hostname = string
    gateway = string
    nameservers = list(string)
    cidr_address = string
  })
}

variable "vm" {
  type = object ({
    node = string
    vlan = string
    bridge = string
    memory_mb = number
    cpu_cores = number 
    disk_size = number
    disk_datastore = string
    file_datastore = string
  })
}

variable "pve" {
  type = object ({
    url = string
    token_id = string
    token_value = string
    ssh_user = string
    ssh_key = string
  })
}
