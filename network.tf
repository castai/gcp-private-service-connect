resource "google_compute_network" "consumer_network" {
  name                    = "consumer-network"
  provider                = google-beta
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "consumer_subnet" {
  name          = "consumer-subnet"
  provider      = google-beta
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.consumer_network.id
}
