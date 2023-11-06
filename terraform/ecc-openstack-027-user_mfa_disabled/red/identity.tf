data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "027-user-red"
  enabled                               = true
  password                              = "password123"
  ignore_change_password_upon_first_use = true
  multi_factor_auth_enabled             = true
  multi_factor_auth_rule {
    rule = ["password", "totp"]
  }
  multi_factor_auth_rule {
    rule = ["password"]
  }
  extra = {
    CustodianRule    = "ecc-openstack-027-user_mfa_disabled"
    ComplianceStatus = "Red"
  }
}

data "openstack_identity_role_v3" "this" {
  name = "member"
}

resource "openstack_identity_role_assignment_v3" "this" {
  user_id    = openstack_identity_user_v3.this.id
  project_id = data.openstack_identity_project_v3.this.id
  role_id    = data.openstack_identity_role_v3.this.id
}