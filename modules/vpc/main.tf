resource "google_compute_network" "vpc-network" {
  project                 = "gcp-001-440816"
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_subnetwork" "vpc-subnet" {
  name          = "vpc-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc-network.self_link
  region        = "europe-west2"
}