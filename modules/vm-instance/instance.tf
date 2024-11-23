# GCP VM - Ubuntu 22.04

locals {
  region            = "europe-west2"
  availability_zone = "europe-west2-c"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "google_compute_instance" "europa" {
  project = var.project_id

  name         = var.instance-name
  machine_type = var.instance-size
  zone         = "${local.region}-c"

  tags = ["europa", "http-server", "https-server"]

  boot_disk {
    auto_delete = true

    initialize_params {
      image = var.image

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

# Output variable: Public IP address
output "public_ip" {
  value = "google_compute_instance.${var.instance-name}.network_interface.0.access_config.0.assigned_nat_ip"
}