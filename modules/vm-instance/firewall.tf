# Create a Google Compute Firewall

resource "google_compute_firewall" "europa-ssh-ipv4" {

  name    = "europa-ssh-http-https"
  network = "vpc-network"

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "80", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  target_tags   = google_compute_instance.europa.tags
}