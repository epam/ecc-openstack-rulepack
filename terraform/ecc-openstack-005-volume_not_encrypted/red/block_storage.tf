resource "openstack_blockstorage_volume_v3" "this" {
  name        = "005-volume-red"
  volume_type = openstack_blockstorage_volume_type_v3.this.name
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-005-volume_not_encrypted
ComplianceStatus = Red
EOT
}

resource "openstack_blockstorage_volume_type_v3" "this" {
  name        = "005-volume-type-red"
  description = "CustodianRule = ecc-openstack-005-volume_not_encrypted, ComplianceStatus = Red"
}