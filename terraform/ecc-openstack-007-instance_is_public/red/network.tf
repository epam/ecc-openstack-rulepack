data "openstack_networking_network_v2" "this" {
  name = "public"
}

data "openstack_networking_subnet_v2" "this" {
  name       = "public-subnet"
  network_id = data.openstack_networking_network_v2.this.id
}

locals {
  old_cidr        = data.openstack_networking_subnet_v2.this.cidr
  cidr_parts      = split(".", local.old_cidr)
  new_third_octet = tostring(tonumber(local.cidr_parts[2]) + 5)
  new_cidr        = "${local.cidr_parts[0]}.${local.cidr_parts[1]}.${local.new_third_octet}.${local.cidr_parts[3]}"
}

resource "openstack_networking_subnet_v2" "this" {
  name        = "007-subnet-red"
  network_id  = data.openstack_networking_network_v2.this.id
  cidr        = local.new_cidr
  ip_version  = 4
  enable_dhcp = true

  tags = [
    "CustodianRule = ecc-openstack-007-instance_is_public",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_v2" "this" {
  name                 = "007-security_group-red"
  description          = "007-security_group-red"
  delete_default_rules = false

  tags = [
    "CustodianRule = ecc-openstack-007-instance_is_public",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "this" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}