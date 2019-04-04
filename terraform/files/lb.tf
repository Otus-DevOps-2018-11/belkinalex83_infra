#provider "google" {
#  version = "1.4.0"
#  project = "${var.project}"
#  region  = "${var.region}"
#  zone    = "${var.zone}"
#}

#Create IPv4 global static external IP addresses for your load balancer.
resource "google_compute_global_address" "lb" {
  name = "global-lb-ip"
}

#Create an instance group
resource "google_compute_instance_group" "reddit_app" {
  name        = "reddit-app"
  description = "Terraform instance group reddit-app"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  #    "${google_compute_instance.app2.self_link}"

  named_port {
    name = "http"
    port = "9292"
  }
}

#Create a health check
resource "google_compute_http_health_check" "reddit_app_healthchk" {
  name         = "reddit-app-healthchk"
  request_path = "/"
  port         = "9292"

  timeout_sec        = 1
  check_interval_sec = 1
}

#Create a backend service
resource "google_compute_backend_service" "reddit_app_backsrv" {
  name        = "reddit-app-backsrv"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    #    group = "${google_compute_instance_group_manager.reddit_app.instance_group}"
    group = "${google_compute_instance_group.reddit_app.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.reddit_app_healthchk.self_link}"]
}

#Create a default URL map that directs all incoming requests to all your instances.
resource "google_compute_url_map" "reddit_app_urlmap" {
  name = "reddit-app-urlmap"

  default_service = "${google_compute_backend_service.reddit_app_backsrv.self_link}"
}

#Create a target HTTP proxy to route requests to your URL map.
resource "google_compute_target_http_proxy" "reddit_app_proxy" {
  name    = "reddit-app-proxy"
  url_map = "${google_compute_url_map.reddit_app_urlmap.self_link}"
}

#Create global forwarding rule to route incoming requests to the proxy
resource "google_compute_global_forwarding_rule" "reddit_app_forward_rule" {
  name       = "reddit-app-forward-rule"
  target     = "${google_compute_target_http_proxy.reddit_app_proxy.self_link}"
  ip_address = "${google_compute_global_address.lb.address}"
  port_range = "80"
}
