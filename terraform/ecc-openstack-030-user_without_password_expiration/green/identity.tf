/*
Prior deploying terraform, check that 'password_expires_days' present in the [security_compliance] section in 'keystone.conf'.
If you deployed DevStack with default settings the file most likely has the '/etc/keystone/keystone.conf' path. 
If the 'password_expires_days' is absent add it and restart the Keystone service: sudo systemctl restart devstack@keystone.service.
Check its status: sudo service devstack@keystone status
*/

data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "030-user-green"
  enabled                               = true
  password                              = "password123"
  ignore_change_password_upon_first_use = true
  ignore_password_expiry                = false

  extra = {
    CustodianRule    = "ecc-openstack-030-user_without_password_expiration"
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