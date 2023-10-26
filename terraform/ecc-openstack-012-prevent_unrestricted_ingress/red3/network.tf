resource "openstack_networking_secgroup_v2" "this" {
  name                 = "012-security_group-red3"
  description          = "012-security_group-red3"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-012-prevent_unrestricted_ingress",
    "ComplianceStatus = Red2"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "this" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0000:0000:0000:0000:0000:0000:0000:0000/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}
