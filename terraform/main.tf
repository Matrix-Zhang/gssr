provider "google" {
  version     = "~> 3.11"
  region      = var.region
  credentials = file(var.credentials_file_path)
}

resource "google_compute_address" "static" {
  name         = "terraform-ssr-ip"
  project      = var.project_name
  address_type = "EXTERNAL"
}

resource "google_compute_network" "network" {
  name                    = "ep-network"
  auto_create_subnetworks = "true"
  project                 = var.project_name
}

# Allow the hosted network to be hit over ICMP, SSH, and HTTP.
resource "google_compute_firewall" "network" {
  name    = "allow-ssh-and-icmp"
  network = google_compute_network.network.self_link
  project = google_compute_network.network.project

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", var.ssr_port]
  }
}

resource "google_compute_instance" "terraform_ssr_vm" {
  name         = "terraform-ssr-vm"
  project      = var.project_name
  machine_type = var.machine_type
  zone         = var.region_zone

  boot_disk {
    initialize_params {
      image = var.image_id
    }
  }

  metadata = {
    startup-script = "ssserver --server-addr 0.0.0.0:${var.ssr_port} --encrypt-method ${var.ssr_encrypt_method} --password ${var.ssr_password}"
    ssh-keys       = "${var.ssh_name}:${file(var.ssh_public_key)}"
  }

  network_interface {
    network = google_compute_firewall.network.network

    access_config {
      // Ephemeral IP
      nat_ip = google_compute_address.static.address
    }
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
