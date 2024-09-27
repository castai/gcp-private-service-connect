variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "psc_region" {
  type        = string
  description = "Region used for PSC endpoint"
}

variable "sample_vm_zone" {
  type        = string
  description = "Zone used to place a sample VM"
}

variable "api_attachment_id" {
  type        = string
  description = "PSC attachment ID used for api.cast.ai endpoint"
}

variable "grpc_attachment_id" {
  type        = string
  description = "PSC attachment ID used for grpc.cast.ai endpoint"
}
