variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "Default GCP Region"
  default = "us-central1"
}

variable "app_location" {
  default = "us-central"
}

variable "gke_tool_server_sa_name" {
  description = "Service account name for gke tool server"
}

variable "environment" {
  description = "Service account name for application"
}
variable "jenkinssrv" {
  description = "Service account name for application"
  type = string
}

variable "myaccount" {
  description = "Service account name for application"
}
variable "gce_ssh_pub_key_file" {
  description = "gce_ssh_pub_key_file account name for application"
}
variable "user" {
    type = string
}
variable "keyPath" {
  description = "keyPath file name for application"
}

variable "secret_manager" {
    type = list(string) 
    default = [
    "secretmanager.googleapis.com"
    ]  
}
variable "roles_gke_tool_server" {
    type = list(string) 
    default = [
    "roles/iap.tunnelResourceAccessor",
    "roles/viewer",
    "roles/storage.admin",
    "roles/cloudbuild.builds.editor",
    "roles/compute.instanceAdmin.v1",
    "roles/iam.serviceAccountUser"
    ]
  
}


variable "application_service_account_roles" {
  type = list(string)
  default = [
    "roles/cloudtrace.agent",
    "roles/compute.networkViewer",
    "roles/datastore.indexAdmin",
    "roles/datastore.user",
    "roles/logging.logWriter",
    "roles/pubsub.editor",
    "roles/pubsub.publisher",
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountTokenCreator",
    "roles/spanner.databaseUser",
    "roles/redis.editor",
    "roles/serviceusage.serviceUsageConsumer",
    "roles/compute.viewer",
    "roles/viewer",
    "roles/container.admin",
    "roles/iam.serviceAccountUser"

  ]
}

