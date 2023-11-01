resource "openstack_blockstorage_volume_v3" "this" {
  name        = "008-volume-green"
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-008-volume_in_state_error
ComplianceStatus = Green
EOT
}
