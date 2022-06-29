resource "google_service_account" "myaccount" {
  account_id = var.myaccount
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.myaccount.name
}


