resource "google_compute_instance" "consumer_vm" {
  name     = "consumer-vm"
  provider = google-beta

  zone         = var.sample_vm_zone
  machine_type = "e2-medium"

  # Use the latest Ubuntu image from the Google Cloud image family
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network    = google_compute_network.consumer_network.name
    subnetwork = google_compute_subnetwork.consumer_subnet.name

    // TODO: Implement Cloud NAT instead of public IP.
    access_config {
      # Ephemeral IP
    }
  }

  # Metadata to allow SSH access from GCP Console
  metadata = {
    enable-oslogin = "TRUE"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Add a tag to match the firewall rule
  tags = ["allow-ssh"]
}

resource "google_compute_firewall" "allow-ssh" {
  name     = "allow-ssh-ingress"
  provider = google-beta

  network = google_compute_network.consumer_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}
