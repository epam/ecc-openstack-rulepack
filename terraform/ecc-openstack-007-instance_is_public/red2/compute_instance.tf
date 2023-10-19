resource "openstack_compute_instance_v2" "this" {
  name            = "007-instance-red"
  image_id        = data.openstack_images_image_ids_v2.this.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.this.id
  security_groups = [openstack_networking_secgroup_v2.this.name]
  network {
    uuid = data.openstack_networking_network_v2.this.id
  }
  tags = [
    "CustodianRule = ecc-openstack-007-instance_is_public",
    "ComplianceStatus = Red"
  ]
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