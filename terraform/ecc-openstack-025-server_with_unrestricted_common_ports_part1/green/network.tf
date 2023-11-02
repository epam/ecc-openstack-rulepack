resource "openstack_networking_network_v2" "this" {
  name           = "025-network-green"
  admin_state_up = "true"

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_subnet_v2" "this" {
  name       = "025-subnet-green"
  network_id = openstack_networking_network_v2.this.id
  cidr       = "192.168.199.0/24"
  ip_version = 4

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_port_v2" "this" {
  name           = "025-port-green"
  network_id     = openstack_networking_network_v2.this.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.this.id
    ip_address = "192.168.199.10"
  }

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Green"
  ]
}

data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

resource "openstack_networking_secgroup_v2" "this" {
  name                 = "025-security_group-green"
  description          = "025-security_group-green"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-025-server_with_unrestricted_common_ports_part1",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 50
  port_range_max    = 65535
  remote_ip_prefix  = "10.0.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.this.id
}

data "openstack_networking_secgroup_v2" "this" {
  name      = "default"
  tenant_id = data.openstack_identity_project_v3.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_group_id   = data.openstack_networking_secgroup_v2.this.id
  security_group_id = openstack_networking_secgroup_v2.this.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3001
  port_range_max    = 3300
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.this.id
}
