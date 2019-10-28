output "db_admin_password" {
  value = random_string.db_admin_password.result
}

output "db_connection_string" {
  value = oci_database_autonomous_database.project_db.connection_strings
}
