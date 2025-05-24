/*
Fetch correct Talos image based on schematic
*/

locals {
  schematic_id = jsondecode(data.http.schematic_id.response_body)["id"]
  schematic = file("${path.module}/assets/talos/image_schematic.yaml")
}

data "http" "schematic_id" {
  url          = "https://factory.talos.dev/schematics"
  method       = "POST"
  request_body = local.schematic
}

resource "proxmox_virtual_environment_download_file" "talos_iso" {
  content_type = "iso"
  datastore_id = var.vm.file_datastore
  node_name    = var.vm.node
  file_name    = "talos.iso"
  url          = "https://factory.talos.dev/image/${local.schematic_id}/${var.cluster.talos_version}/nocloud-amd64.raw.gz"
  decompression_algorithm = "gz"
  overwrite    = false
}
