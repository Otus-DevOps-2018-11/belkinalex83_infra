variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable private_key_path {
  description = "Path to the private key used for ssh access provisioners"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable machine_type {
  default = "g1-small"
}

variable env {
  description = "Environment"
}

variable db_internal_ip {
  description = "Internal IP address DB"
}

variable provision_enabled {
  description = "Enable provision"
  default = "false"
}

