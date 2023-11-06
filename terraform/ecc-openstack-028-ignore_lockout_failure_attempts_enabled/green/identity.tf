data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "028-user-green"
  enabled                               = true
  password                              = "password123"
  ignore_change_password_upon_first_use = true
  ignore_lockout_failure_attempts       = false

  extra = {
    CustodianRule    = "ecc-openstack-028-ignore_lockout_failure_attempts_enabled"
    ComplianceStatus = "Green"
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