provider "oci" {
  region = var.region
}

resource "random_string" "db_admin_password" {
  length  = 16
  special = false
}

resource "oci_identity_compartment" "project_compartment" {
  compartment_id = var.tenancy_ocid
  description    = "Compartment for the ${var.project_name} project"
  name           = var.project_name
}

resource "oci_database_autonomous_database" "project_db" {
  is_free_tier = "true"
  
  admin_password = random_string.db_admin_password.result
  compartment_id = oci_identity_compartment.project_compartment.id
  db_name        = "${var.project_short_name}db"
  data_storage_size_in_tbs = 1
  cpu_core_count = 1
}

