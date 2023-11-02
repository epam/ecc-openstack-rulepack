resource "openstack_networking_network_v2" "this" {
  name           = "026-network-red"
  admin_state_up = "true"

  tags = [
    "CustodianRule = ecc-openstack-026-server_with_unrestricted_common_ports_part2",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_subnet_v2" "this" {
  name       = "026-subnet-red"
  network_id = openstack_networking_network_v2.this.id
  cidr       = "192.168.199.0/24"
  ip_version = 4

  tags = [
    "CustodianRule = ecc-openstack-026-server_with_unrestricted_common_ports_part2",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_port_v2" "this" {
  name           = "026-port-red"
  network_id     = openstack_networking_network_v2.this.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.this.id
    ip_address = "192.168.199.10"
  }

  tags = [
    "CustodianRule = ecc-openstack-026-server_with_unrestricted_common_ports_part2",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_v2" "this1" {
  name                 = "026-security_group-red1"
  description          = "026-security_group-red1"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-026-server_with_unrestricted_common_ports_part2",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_v2" "this2" {
  name                 = "026-security_group-red2"
  description          = "026-security_group-red2"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-026-server_with_unrestricted_common_ports_part2",
    "ComplianceStatus = Red"
  ]
}


resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3000
  port_range_max    = 3400
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}


resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 4333
  port_range_max    = 4333
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5000
  port_range_max    = 5000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this2.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5000
  port_range_max    = 5500
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this2.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5601
  port_range_max    = 5602
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_6" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 8000
  port_range_max    = 10000
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}
