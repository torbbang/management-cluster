cluster = {
  name = ""
  endpoint = ""
  talos_version = ""
  k8s_version = ""
}

node = {
  hostname = ""
  gateway = ""
  nameservers = [""]
  cidr_address = ""
}

vm = {
 node = ""
 vlan =  # Number, VLAN ID
 bridge = ""
 disk_size = # Number in GB
 cpu_cores = # Number, count
 memory_mb = # Number, MB of memory
 disk_datastore = "local-lvm"
 file_datastore = "local"
}
