resource "openstack_networking_network_v2" "this" {
  name           = "025-network-red"
  admin_state_up = "true"

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_subnet_v2" "this" {
  name       = "025-subnet-red"
  network_id = openstack_networking_network_v2.this.id
  cidr       = "192.168.199.0/24"
  ip_version = 4

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_port_v2" "this" {
  name           = "025-port-red"
  network_id     = openstack_networking_network_v2.this.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.this.id
    ip_address = "192.168.199.10"
  }

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_v2" "this1" {
  name                 = "025-security_group-red1"
  description          = "025-security_group-red1"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_v2" "this2" {
  name                 = "025-security_group-red2"
  description          = "025-security_group-red2"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Red"
  ]
}


resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 20
  port_range_max    = 23
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}


resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 25
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this2.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 25
  port_range_max    = 143
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this2.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_6" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 1433
  port_range_max    = 1434
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.this1.id
}
