resource "openstack_identity_project_v3" "this" {
  name = "015-project-red"
  tags = [
    "CustodianRule = ecc-openstack-015-default_security_group_not_restricts_all_traffic",
    "ComplianceStatus = Red"
  ]
}

data "openstack_networking_secgroup_v2" "this" {
  name      = "default"
  tenant_id = openstack_identity_project_v3.this.id
}

resource "openstack_networking_secgroup_rule_v2" "this" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = data.openstack_networking_secgroup_v2.this.id
  tenant_id         = openstack_identity_project_v3.this.id
  description       = <<EOT
CustodianRule = ecc-openstack-015-default_security_group_not_restricts_all_traffic
ComplianceStatus = Red
EOT

  depends_on = [data.openstack_networking_secgroup_v2.this, openstack_identity_project_v3.this]
}

resource "null_resource" "this" {
  triggers = {
    profile    = var.profile
    sg_id      = data.openstack_networking_secgroup_v2.this.id
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<CMD
    export OS_CLOUD=${self.triggers.profile}
    openstack security group delete ${self.triggers.sg_id}
    CMD
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [openstack_identity_project_v3.this]
}