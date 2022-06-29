resource "google_compute_firewall" "firewall" {
  name    = "gritfy-firewall-externalssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["externalssh"]
}
resource "google_compute_firewall" "webserverrule" {
  name    = "gritfy-webserver"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80","443","8080"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["webserver"]
}
# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
  project = var.project_id
  region = var.region
  depends_on = [ google_compute_firewall.firewall ]
}




resource "google_compute_instance" "jenkins-instance" {
    name = var.jenkinssrv
    machine_type = "e2-medium"
    zone = "us-central1-a"
    tags         = ["externalssh","webserver"]
    

    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
      }
    }
    network_interface {
      network = "default"
      access_config {
         nat_ip = google_compute_address.static.address
      }
    }
    service_account {
        email = google_service_account.myaccount.email
        scopes = ["cloud-platform"]
    }

      metadata = {
      ssh-keys = "${var.user}:${file(var.gce_ssh_pub_key_file)}"
  }

    provisioner "remote-exec" {
         connection {
       type        = "ssh"
       user        = "ubuntu"
       private_key = file(var.keyPath)
       timeout     = "500s"
       host = google_compute_address.static.address
     }
     inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo nginx -v",
    ]
    }
    
     # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = [ google_compute_firewall.firewall, google_compute_firewall.webserverrule ]
   }

   resource "null_resource" "cluster" {
  provisioner "file" {
    source      = "C:\\Users\\kugaveka\\Desktop\\GKE_Cluster\\Scripts\\jenkins.sh"
    destination = "/tmp/jenkins.sh"
  }

  connection {
       type        = "ssh"
       user        = "ubuntu"
       private_key = file(var.keyPath)
       timeout     = "500s"
       host = google_compute_address.static.address
  }
}

resource "null_resource" "cluster1" {
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins.sh",
      "cd /tmp",
      "./jenkins.sh"
    ]
  }

  connection {
       type        = "ssh"
       user        = "ubuntu"
       private_key = file(var.keyPath)
       timeout     = "500s"
       host = google_compute_address.static.address
  }
}

 

output "ip" {
  value = google_compute_address.static.address
}