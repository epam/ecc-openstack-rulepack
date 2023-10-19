resource "openstack_compute_instance_v2" "this" {
  name            = "006-instance-green"
  image_id        = data.openstack_images_image_ids_v2.this.ids[0]
  flavor_id       = data.openstack_compute_flavor_v2.this.id
  security_groups = ["default"]
  network {
    name = openstack_networking_network_v2.this.name
  }
  block_device {
    source_type           = "blank"
    destination_type      = "volume"
    volume_size           = 1
    boot_index            = 0
    delete_on_termination = true
  }

  tags = [
    "CustodianRule = ecc-openstack-006-instance_volume_dele",
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