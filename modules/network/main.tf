resource "google_compute_network" "private_network" {
  project                 = var.project_id
  name                    = var.network_name != "" ? var.network_name : var.network_name_local
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow-internal" {
  project = var.project_id
  name    = var.network_name != "" ? "${var.network_name}-allow-internal" : "${var.network_name_local}-allow-internal"
  network = google_compute_network.private_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  # Default internal range where our private network subnetworks are deployed.
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network#auto_create_subnetworks
  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_global_address" "private_ip_addresses" {
  project       = var.project_id
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.name
}

resource "google_service_networking_connection" "peering_connection" {
  provider                = "google-beta"
  network                 = google_compute_network.private_network.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_addresses.name]
}

data "google_compute_network" "default" {
  project = var.project_id
  name    = google_compute_network.private_network.name
  depends_on = [
    google_service_networking_connection.peering_connection,
  ]
}
