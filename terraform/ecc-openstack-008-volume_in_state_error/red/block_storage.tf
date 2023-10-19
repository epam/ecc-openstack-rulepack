resource "openstack_blockstorage_volume_v3" "this" {
  name        = "008-volume-red"
  size        = 2
  description = <<EOT
CustodianRule = ecc-openstack-008-volume_in_state_error
ComplianceStatus = Red
EOT

  provisioner "local-exec" {
    command = <<CMD
      export OS_CLOUD=${var.profile}
      openstack volume set --state error ${self.name}
  CMD

    interpreter = ["/bin/bash", "-c"]
  }
}
