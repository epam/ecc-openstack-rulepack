resource "openstack_identity_project_v3" "this" {
  name = "009-project-green"
  tags = [
    "CustodianRule = ecc-openstack-001-instance_has_default_sg_at",
    "ComplianceStatus = Green"
  ]
}
