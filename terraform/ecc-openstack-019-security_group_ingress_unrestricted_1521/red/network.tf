resource "openstack_networking_secgroup_v2" "this" {
  name                 = "019-security_group-red"
  description          = "019-security_group-red"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-019-security_group_ingress_unrestricted_1521",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1521
  port_range_max    = 1521
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}