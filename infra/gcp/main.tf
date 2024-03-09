/**

See https://medium.com/stream-zero/creating-a-deeplearning-vm-in-google-cloud-with-terraform-f3db8ae98d3c

**/

provider "google" {
 	project = var.gcp_project
 	region = var.gcp_region
}

resource "random_id" "instance_id" {
  byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "ollama" {
  name         = "ollama-${random_id.instance_id.hex}"
  machine_type = "n1-standard-1"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size = 60
    }
  }

  guest_accelerator {
    type  = "nvidia-tesla-t4"
    count = 1
  }

  scheduling {
    on_host_maintenance = "TERMINATE"
  }

  /* 
  metadata_startup_script = "sudo apt-get update; sudo apt-get -y upgrade; curl -fsSL https://ollama.com/install.sh | sh " 
  */

  network_interface {
    network = "default"
    access_config  {}
  }
}

output "ip" {
 value = "google_compute_instance.myvm.network_interface.0.access_config.0.nat_ip"
}
