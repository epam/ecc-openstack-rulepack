resource "openstack_networking_secgroup_v2" "this" {
  name                 = "021-security_group-green"
  description          = "021-security_group-green"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-021-security_group_ingress_unrestricted_5432",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 9090
  remote_ip_prefix  = "10.0.0.0/16"
  security_group_id = openstack_networking_secgroup_v2.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}

