

resource "google_container_cluster" "gke" {
  name                     = local.gke_cluster_name
  location                 = var.location
  project                  = data.google_project.dev-k8s.project_id
  networking_mode          = "VPC_NATIVE"
  subnetwork               = var.subnetwork
  initial_node_count       = 1
  node_version = var.gke_version
  remove_default_node_pool = false

  maintenance_policy {
         daily_maintenance_window {
        start_time = "03:00"
       }
   }
    release_channel {
    channel = "REGULAR" // or less frequently update fro production STABLE
    }
     network_policy {
    provider = "PROVIDER_UNSPECIFIED"
    enabled = true
  }

  addons_config{
      gcp_filestore_csi_driver_config {
      enabled = true
    }
  }
  node_config {
 
    machine_type = "e2-medium"
    disk_size_gb = var.worker_nodes_disk_size
  }

}



