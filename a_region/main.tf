module "environment" {
  source = "../b_environment"
  region = "${var.region}"
  network = "${var.network}"
  network_offset = "${var.network_offset}"
  availability_zones = "${var.availability_zones}"
}

variable "region" { default = "us-east-1" }
variable "network" { default = "172.16.0.0/24"}
variable "network_offset" { default = 0 }
variable "availability_zones"  { default = "us-east-1a,us-east-1b" }
