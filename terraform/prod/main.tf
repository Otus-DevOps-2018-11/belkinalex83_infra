provider "google" {
  version = "1.19.1"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source            = "../modules/app"
  public_key_path   = "${var.public_key_path}"
  zone              = "${var.zone}"
  app_disk_image    = "${var.app_disk_image}"
  env               = "${var.env}"
  private_key_path  = "${var.private_key_path}"
  db_internal_ip    = "${module.db.db_internal_ip}"
  provision_enabled = true
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  env              = "${var.env}"
  private_key_path = "${var.private_key_path}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["35.204.114.88/32"]
  env           = "${var.env}"
}
