output "client_configuration" {
  value     = talos_machine_secrets.cluster.client_configuration
  sensitive = true
}

output "kubeconfig" {
  value       = talos_cluster_kubeconfig.cluster.kubeconfig_raw
  sensitive   = true
}
