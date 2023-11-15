resource "openstack_keymanager_secret_v1" "this" {
  name                     = "031-secret-red"
  payload                  = base64encode("password with the whitespace at the end ")
  secret_type              = "passphrase"
  payload_content_type     = "application/octet-stream"
  payload_content_encoding = "base64"

  metadata = {
    "CustodianRule"    = "ecc-openstack-031-secret_without_expiration",
    "ComplianceStatus" = "Red"
  }
}