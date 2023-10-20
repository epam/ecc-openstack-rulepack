resource "openstack_blockstorage_volume_v3" "this" {
  name        = "011-volume-green"
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-002-volume_not_in_use
ComplianceStatus = Green
EOT
  metadata = {
    "CustodianRule"    = "ecc-openstack-002-volume_not_in_use"
    "ComplianceStatus" = "Green"
  }
}
