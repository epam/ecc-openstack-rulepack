resource "openstack_blockstorage_volume_v3" "this" {
  name        = "002-volume-green"
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-002-volume_not_in_use
ComplianceStatus = Green
EOT
}

resource "openstack_compute_volume_attach_v2" "this" {
  instance_id = openstack_compute_instance_v2.this.id
  volume_id   = openstack_blockstorage_volume_v3.this.id

  depends_on = [openstack_blockstorage_volume_v3.this, openstack_compute_instance_v2.this]
}