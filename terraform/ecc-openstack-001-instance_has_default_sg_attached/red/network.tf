resource "openstack_networking_network_v2" "this" {
  name           = "001-network-red"
  admin_state_up = "true"

  tags = [
    "CustodianRule = ecc-openstack-001-instance_has_default_sg_attached",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_subnet_v2" "this" {
  name       = "001-subnet-red"
  network_id = openstack_networking_network_v2.this.id
  cidr       = "192.168.199.0/24"
  ip_version = 4

  tags = [
    "CustodianRule = ecc-openstack-001-instance_has_default_sg_attached",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_port_v2" "this" {
  name           = "001-port-red"
  network_id     = openstack_networking_network_v2.this.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.this.id
    ip_address = "192.168.199.10"
  }

  tags = [
    "CustodianRule = ecc-openstack-001-instance_has_default_sg_attached",
    "ComplianceStatus = Red"
  ]
}

resource "openstack_networking_secgroup_v2" "this" {
  name                 = "001-security_group-red"
  description          = "001-security_group-red"
  delete_default_rules = true

  tags = [
    "CustodianRule = ecc-openstack-001-instance_has_default_sg_attached",
    "ComplianceStatus = Red"
  ]
}
