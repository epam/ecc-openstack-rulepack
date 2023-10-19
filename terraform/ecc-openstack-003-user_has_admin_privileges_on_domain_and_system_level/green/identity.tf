data "openstack_identity_project_v3" "this" {
  name = "demo"
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "003-user-green"
  enabled                               = true
  password                              = "password123"
  ignore_change_password_upon_first_use = true

  extra = {
    CustodianRule    = "ecc-openstack-003-user_has_admin_privileges_on_domain_and_system_level"
    ComplianceStatus = "Green"
  }
}

data "openstack_identity_role_v3" "this" {
  name = "admin"
}

resource "openstack_identity_role_assignment_v3" "this" {
  user_id    = openstack_identity_user_v3.this.id
  project_id = data.openstack_identity_project_v3.this.id
  role_id    = data.openstack_identity_role_v3.this.id
}


