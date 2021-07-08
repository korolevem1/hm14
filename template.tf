
variable "input_values" {
  type = map
  default =  {
    "kolvo" = "1"
    "cpu" = 2
    "memory" = 4

  }
}




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
  count = var.input_values["kolvo"]
  name = "test-${count.index + 1}"
 # machine_type = "e2-medium"
  zone         = "us-central1-a"
  machine_type = "custom-${var.input_values["cpu"]}-${var.input_values["memory"]*1024}-ext"
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


}