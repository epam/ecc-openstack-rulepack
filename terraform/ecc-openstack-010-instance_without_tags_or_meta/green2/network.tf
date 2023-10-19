resource "openstack_networking_network_v2" "this" {
  name           = "010-network-green"
  admin_state_up = "true"

  tags = [
    "CustodianRule = ecc-openstack-010-instance_without_tags_or_meta",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_subnet_v2" "this" {
  name       = "010-subnet-green"
  network_id = openstack_networking_network_v2.this.id
  cidr       = "192.168.199.0/24"
  ip_version = 4

  tags = [
    "CustodianRule = ecc-openstack-010-instance_without_tags_or_meta",
    "ComplianceStatus = Green"
  ]
}

resource "openstack_networking_port_v2" "this" {
  name           = "010-port-green"
  network_id     = openstack_networking_network_v2.this.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.this.id
    ip_address = "192.168.199.10"
  }

  tags = [
    "CustodianRule = ecc-openstack-010-instance_without_tags_or_meta",
    "ComplianceStatus = Green"
  ]
}