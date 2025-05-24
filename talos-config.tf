resource "talos_machine_secrets" "cluster" {
  talos_version = var.cluster.talos_version
}

data "talos_machine_configuration" "config" {
  cluster_name     = var.cluster.name
  cluster_endpoint = var.cluster.endpoint
  talos_version    = var.cluster.talos_version
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.cluster.machine_secrets
  config_patches   = [ templatefile("${path.module}/assets/talos/machine-config.tftpl", { hostname = var.node.hostname, k8s_version = var.cluster.k8s_version }) ]
}

resource "talos_machine_configuration_apply" "nodeconfig" {
  depends_on = [proxmox_virtual_environment_vm.node]
  node                        = element( split("/", var.node.cidr_address), 0)
  client_configuration        = talos_machine_secrets.cluster.client_configuration
  machine_configuration_input = data.talos_machine_configuration.config.machine_configuration
  lifecycle {
    replace_triggered_by = [proxmox_virtual_environment_vm.node]
  }
}

resource "talos_machine_bootstrap" "cluster" {
  node                 = element( split("/", var.node.cidr_address), 0)
  endpoint             = element( split("/", var.node.cidr_address), 0)
  client_configuration = talos_machine_secrets.cluster.client_configuration
}

data "talos_cluster_health" "cluster" {
  depends_on = [
    talos_machine_configuration_apply.nodeconfig,
    talos_machine_bootstrap.cluster
  ]
  client_configuration = talos_machine_secrets.cluster.client_configuration
  endpoints            = [ element( split("/", var.node.cidr_address), 0) ]
  control_plane_nodes  = [ element( split("/", var.node.cidr_address), 0) ]
#  control_plane_nodes  = [ var.cluster.endpoint ]
  timeouts = {
    read = "10m"
  }
}

resource "talos_cluster_kubeconfig" "cluster" {
  depends_on = [
    talos_machine_bootstrap.cluster,
    data.talos_cluster_health.cluster
  ]
  node                 = element( split("/", var.node.cidr_address), 0)
  client_configuration = talos_machine_secrets.cluster.client_configuration
  timeouts = {
    read = "1m"
  }
}
