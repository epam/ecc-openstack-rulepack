resource "openstack_keymanager_secret_v1" "this" {
  name                     = "031-secret-green"
  payload                  = base64encode("password with the whitespace at the end ")
  secret_type              = "passphrase"
  payload_content_type     = "application/octet-stream"
  payload_content_encoding = "base64"
  expiration               = timeadd(timestamp(), format("%dh", 8760)) # one year in hours
  lifecycle {
    ignore_changes = [
      expiration
    ]
  }

  metadata = {
    "CustodianRule"    = "ecc-openstack-031-secret_without_expiration",
    "ComplianceStatus" = "Green"
  }
}