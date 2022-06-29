resource "google_project_service" "google_apis" {
  project = var.project_id
  count = length(var.secret_manager)  
  service = element(var.secret_manager, count.index)
}