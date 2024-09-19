resource "google_dns_managed_zone" "consumer_psc_zone" {
  name     = "consumer-psc-zone"
  provider = google-beta

  dns_name      = "cast.ai."
  force_destroy = false

  visibility = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.consumer_network.id
    }
  }
}

resource "google_dns_record_set" "api" {
  name     = "psc-api.europe-west1.p.api.cast.ai."
  provider = google-beta

  managed_zone = google_dns_managed_zone.consumer_psc_zone.name
  type         = "A"
  rrdatas      = [google_compute_address.psc_api_address.address]
}

resource "google_dns_record_set" "grpc" {
  name     = "psc-grpc.europe-west1.p.grpc.cast.ai."
  provider = google-beta

  managed_zone = google_dns_managed_zone.consumer_psc_zone.name
  type         = "A"
  rrdatas      = [google_compute_address.psc_grpc_address.address]
}
