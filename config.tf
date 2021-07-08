terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.74.0"
    }
  }
}

provider "google" {
  # Configuration options
project = "micro-shoreline-313408"
region = "us-central1"
}


resource "google_compute_instance" "default" {
  name         = "test4"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210623"
    }
  }

 

network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
}



  # ...

  provisioner "local-exec" {
    command = "gcloud compute ssh test4 --zone=us-central1-a --ssh-key-file ~/.ssh/id_rsa  --command=\"apt install nginx -y\""
  }