terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1"
    }
  }
}

provider "openstack" {
  cloud       = var.profile
  # tenant_name = var.project_name
}