variable "region" { default = "us-east-1" }
variable "network" { default = "172.16.0.0/24"}
variable "network_offset" { default = 0 }
variable "availability_zones"  { default = "us-east-1a,us-east-1b" }

resource "aws_vpc" "vpc" {
  cidr_block = "${cidrsubnet(var.network, 7, var.network_offset)}"
}

resource "aws_internet_gateway" "ig" {
	vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "vpc-a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 1, 0)}"
  availability_zone = "${element(split(",", var.availability_zones), 0)}"
  map_public_ip_on_launch = false
}
resource "aws_subnet" "vpc-b" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 1, 1)}"
  availability_zone = "${element(split(",", var.availability_zones), 1)}"
  map_public_ip_on_launch = false
}

resource "aws_route_table_association" "subnet-a" {
  subnet_id = "${aws_subnet.vpc-a.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}
resource "aws_route_table_association" "subnet-b" {
  subnet_id = "${aws_subnet.vpc-b.id}"
  route_table_id = "${aws_vpc.vpc.main_route_table_id}"
}
