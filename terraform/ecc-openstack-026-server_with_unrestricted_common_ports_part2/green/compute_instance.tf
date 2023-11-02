resource "openstack_compute_instance_v2" "this" {
  name            = "026-instance-green"
  image_id        = data.openstack_images_image_ids_v2.this.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.this.id
  security_groups = [openstack_networking_secgroup_v2.this.name]
  network {
    name = openstack_networking_network_v2.this.name
  }
  tags = [
    "CustodianRule = ecc-openstack-026-server_with_unrestri",
    "ComplianceStatus = Green"
  ]

  depends_on = [openstack_networking_subnet_v2.this]
}

data "openstack_images_image_ids_v2" "this" {
  name_regex = "^cirros-.*-x86_64-disk"
  sort       = "updated_at"
}

data "openstack_compute_flavor_v2" "this" {
  vcpus     = 1
  ram       = 256
  disk      = 1
  is_public = true
}