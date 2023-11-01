data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "004-user-red"
  enabled                               = false
  password                              = "password123"
  ignore_change_password_upon_first_use = true

  extra = {
    CustodianRule    = "ecc-openstack-004-user_disabled"
    ComplianceStatus = "Red"
  }
}

