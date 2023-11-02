resource "openstack_networking_secgroup_v2" "this" {
  name                 = "022-security_group-red2"
  description          = "022-security_group-red2"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-022-security_group_ingress_unrestricted_23",
    "ComplianceStatus = Red2"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "this" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}