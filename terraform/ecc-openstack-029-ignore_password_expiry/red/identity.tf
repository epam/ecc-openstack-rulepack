/*
Prior deploying terraform, check that 'password_expires_days = 10' present in the [security_compliance] section in 'keystone.conf'.
If you deployed DevStack with default settings the file most likely has the '/etc/keystone/keystone.conf' path. 
If the 'password_expires_days' is absent add it and restart the Keystone service: sudo systemctl restart devstack@keystone.service.
Check its status: sudo service devstack@keystone status
*/

/*
To test that user's password actually does not expire, and to avoid waiting set 'password_expires_days' value, it's possible to update expiration time.
1. Login to the database: `mysql -h localhost -u root -p`

2. Set working database:
```
SHOW DATABASES;
USE keystone;
show tables;
```

3. Find user 'id' in database (it is different from 'user_id'):  `select * from local_user;`

4. View current expiration date, where instead of '{id}' insert 'local_user_id' found on the previous step: `select * from password where local_user_id = {id};`

5. You can change expiration date to the nearest time that you want, for example in 10 minutes:
```
UPDATE password SET expires_at_int = '1699346820000000' WHERE local_user_id = 41;
UPDATE password SET expires_at = '2023-11-07 09:47:00' WHERE local_user_id = 41;
```
*/


data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

resource "openstack_identity_user_v3" "this" {
  default_project_id                    = data.openstack_identity_project_v3.this.id
  name                                  = "029-user-red"
  enabled                               = true
  password                              = "password123"
  ignore_change_password_upon_first_use = true
  ignore_password_expiry                = true

  extra = {
    CustodianRule    = "ecc-openstack-029-ignore_password_expiry"
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