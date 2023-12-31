resource "openstack_compute_instance_v2" "this" {
  name            = "010-instance-green2"
  image_id        = data.openstack_images_image_ids_v2.this.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.this.id
  security_groups = ["default"]
  network {
    name = openstack_networking_network_v2.this.name
  }
  metadata = {
    "CustodianRule"    = "ecc-openstack-010-instance_without_tag",
    "ComplianceStatus" = "Green2"
  }
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