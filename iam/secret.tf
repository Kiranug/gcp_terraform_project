
resource "google_secret_manager_secret" "myaccount" {
  secret_id = "gke-app-sa"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "myaccount" {
  secret = google_secret_manager_secret.myaccount.id
  secret_data = base64decode(google_service_account_key.mykey.private_key)
}