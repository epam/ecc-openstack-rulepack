# Prerequisites: https://docs.openstack.org/cinder/2023.2/configuration/block-storage/volume-encryption.html

locals {
  volume_type_name = "005-volume-type-green"
}

resource "openstack_blockstorage_volume_v3" "this" {
  name        = "005-volume-green"
  volume_type = local.volume_type_name
  size        = 1
  description = <<EOT
CustodianRule = ecc-openstack-005-volume_not_encrypted
ComplianceStatus = Green
EOT

  depends_on = [null_resource.this]
}

resource "null_resource" "this" {
  triggers = {
    profile          = var.profile
    volume_type_name = local.volume_type_name
  }

  provisioner "local-exec" {
    command = <<CMD
      export OS_CLOUD=${var.profile}

      openstack volume type create --encryption-provider luks --encryption-cipher aes-xts-plain64 --encryption-key-size 256 --encryption-control-location front-end ${local.volume_type_name} --description "CustodianRule = ecc-openstack-005-volume_not_encrypted, ComplianceStatus = Green" --private &> /dev/null
  CMD

    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
    export OS_CLOUD=${self.triggers.profile}
    openstack volume type delete ${self.triggers.volume_type_name}
    CMD
    interpreter = ["/bin/bash", "-c"]
  }
}
