data "openstack_networking_network_v2" "this" {
  name = "private"
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

resource "openstack_networking_floatingip_v2" "this" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "this" {
  floating_ip = openstack_networking_floatingip_v2.this.address
  instance_id = openstack_compute_instance_v2.this.id
}
