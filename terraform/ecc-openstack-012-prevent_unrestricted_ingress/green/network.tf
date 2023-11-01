resource "openstack_networking_secgroup_v2" "this" {
  name                 = "012-security_group-green"
  description          = "012-security_group-green"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-012-prevent_unrestricted_ingress",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 2
  port_range_max    = 65535
  remote_ip_prefix  = "0000:0000:0000:0000:0000:0000:0000:0000/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = data.openstack_networking_secgroup_v2.this.id
  security_group_id = openstack_networking_secgroup_v2.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  security_group_id = openstack_networking_secgroup_v2.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_group_id   = data.openstack_networking_secgroup_v2.this.id
  security_group_id = openstack_networking_secgroup_v2.this.id
}

data "openstack_networking_secgroup_v2" "this" {
  name      = "default"
  tenant_id = data.openstack_identity_project_v3.this.id
}

data "openstack_identity_project_v3" "this" {
  name = var.project_name
}