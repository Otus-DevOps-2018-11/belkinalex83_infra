resource "google_compute_instance" "app" {
  name         = "reddit-app-${var.env}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "null_resource" "app" {
	count = "${var.provision_enabled ? 1 : 0}"
	
 provisioner "file" {
    source      = "/home/al/belkinalex83_infra/terraform/modules/app/puma.service"
    destination = "/tmp/puma.service"
  }

 provisioner "remote-exec" {
  inline = [
		"echo 'export DATABASE_URL=${var.db_internal_ip}' >> ~/.profile",
		"export DATABASE_URL=${var.db_internal_ip}"
  ]	
  }

 provisioner "remote-exec" {
  script =       "/home/al/belkinalex83_infra/terraform/modules/app/deploy.sh"
}

 connection {
    host = "${google_compute_instance.app.network_interface.0.access_config.0.assigned_nat_ip}"
    type     = "ssh"
    user     = "appuser"
    private_key = "${file(var.private_key_path)}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip-${var.env}"
}
