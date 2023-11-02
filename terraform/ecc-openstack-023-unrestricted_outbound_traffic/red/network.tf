resource "openstack_networking_secgroup_v2" "this" {
  name                 = "023-security_group-red"
  description          = "023-security_group-red"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-023-unrestricted_outbound_traffic",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
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