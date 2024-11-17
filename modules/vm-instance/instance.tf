# GCP VM - Ubuntu 22.04

data "google_compute_image" "europa" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

locals {
  region            = "europe-west2"
  availability_zone = "europe-west2-c"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "google_compute_instance" "europa" {
  project = var.project_id

  name         = var.name
  machine_type = "e2-micro"
  zone         = "${local.region}-c"

  tags = ["europa", "http-server", "https-server"]

  boot_disk {
    auto_delete = true

    initialize_params {
      image = data.google_compute_image.europa.self_link

      labels = {
        managed_by = "terraform"
      }
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }


  metadata = {
    sshKeys = "ubuntu:${tls_private_key.ssh.public_key_openssh}"
  }

  # We can install any tools we need for the europa VM in the startup script
  metadata_startup_script = <<EOT
  set -xe \
    && sudo apt update -y \
    && sudo apt install htop -y 
EOT

}

# Terraform create the ssh keys
resource "local_file" "local_ssh_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = ".ssh/ssh_key"
  file_permission = "0600"
}

resource "local_file" "local_ssh_key_pub" {
  content         = tls_private_key.ssh.public_key_openssh
  filename        = ".ssh/ssh_key.pub"
  file_permission = "0600"
}

output "instance_ssh_key" {
  value      = ".ssh/ssh_key"
  depends_on = [tls_private_key.ssh]
}

output "instance_ip" {
  value = google_compute_instance.europa.network_interface.0.access_config.0.nat_ip
}