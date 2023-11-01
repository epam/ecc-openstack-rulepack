resource "openstack_blockstorage_volume_v3" "this" {
  name        = "006-volume-red"
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-006-instance_volume_delete_on_termination_disabled
ComplianceStatus = Red
EOT
}

resource "openstack_compute_volume_attach_v2" "this" {
  instance_id = openstack_compute_instance_v2.this.id
  volume_id   = openstack_blockstorage_volume_v3.this.id

  depends_on = [openstack_blockstorage_volume_v3.this, openstack_compute_instance_v2.this]
}

