# vpc.tf
resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh-${var.env}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default-${var.env}"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_nginx" {
  name = "default-allow-nginx-${var.env}"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["reddit-app"]
}
