data "openstack_identity_project_v3" "this" {
  name = "demo"
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "003-user-red2"
  enabled                               = true
  password                              = "password123"
  ignore_change_password_upon_first_use = true

  extra = {
    CustodianRule    = "ecc-openstack-003-user_has_admin_privileges_on_domain_and_system_level"
    ComplianceStatus = "Red"
  }
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command     = "export OS_CLOUD=${var.profile}; openstack role add --system all --user ${openstack_identity_user_v3.this.name}  admin"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [
    openstack_identity_user_v3.this,
    data.openstack_identity_project_v3.this
  ]
}
