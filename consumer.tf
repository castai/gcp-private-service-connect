resource "google_compute_address" "psc_api_address" {
  name         = "private-service-connect-address"
  provider     = google-beta
  subnetwork   = google_compute_subnetwork.consumer_subnet.id
  address_type = "INTERNAL"
}

resource "google_compute_forwarding_rule" "api" {
  name     = "psc-api"
  provider = google-beta

  load_balancing_scheme   = ""
  target                  = var.api_attachment_id
  network                 = google_compute_network.consumer_network.name
  ip_address              = google_compute_address.psc_api_address.id
  no_automate_dns_zone    = true
  allow_psc_global_access = false
}

resource "google_compute_address" "psc_grpc_address" {
  name         = "private-service-connect-address2"
  provider     = google-beta
  subnetwork   = google_compute_subnetwork.consumer_subnet.id
  address_type = "INTERNAL"
}

resource "google_compute_forwarding_rule" "grpc" {
  name     = "psc-grpc"
  provider = google-beta

  load_balancing_scheme   = ""
  target                  = var.grpc_attachment_id
  network                 = google_compute_network.consumer_network.name
  ip_address              = google_compute_address.psc_grpc_address.id
  no_automate_dns_zone    = true
  allow_psc_global_access = false
}
