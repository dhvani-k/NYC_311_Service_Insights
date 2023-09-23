resource "google_artifact_registry_repository" "nyc_311_stat_pipeline" {
  repository_id = "nyc_311_stat_pipeline"
  location      = var.GCP_REGION
  format        = "docker"
}