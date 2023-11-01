resource "openstack_identity_project_v3" "this" {
  name = "009-project-green"
  tags = [
    "CustodianRule = ecc-openstack-009-project_without_tags",
    "ComplianceStatus = Green"
  ]
}
