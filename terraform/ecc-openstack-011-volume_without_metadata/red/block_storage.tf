resource "openstack_blockstorage_volume_v3" "this" {
  name        = "011-volume-red"
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-011-volume_without_metadata
ComplianceStatus = Red
EOT
}
