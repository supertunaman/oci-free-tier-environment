resource "oci_core_vcn" "project_vcn" {
  cidr_block     = var.cidr_block
  compartment_id = oci_identity_compartment.project_compartment.id
  display_name   = var.project_name
}

###
# Private Subnet Resources
###

resource "oci_core_nat_gateway" "private_nat_gateway" {
  vcn_id = oci_core_vcn.project_vcn.id
  compartment_id = oci_identity_compartment.project_compartment.id
  display_name = "${var.project_name} Private Subnet NAT Gateway"
}

resource "oci_core_route_table" "private_route_table" {
  vcn_id = oci_core_vcn.project_vcn.id
  compartment_id = oci_identity_compartment.project_compartment.id
  display_name = "${var.project_name} Private Subnet Route Table"
  
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.private_nat_gateway.id
  }
}

resource "oci_core_subnet" "private_subnet" {
  vcn_id = oci_core_vcn.project_vcn.id
  compartment_id = oci_identity_compartment.project_compartment.id
  cidr_block = cidrsubnet(var.cidr_block, 1, 0)
  display_name   = "${var.project_name} Private Subnet"
  route_table_id = oci_core_route_table.private_route_table.id
}

###
# Public Subnet Resources
###

resource "oci_core_internet_gateway" "public_internet_gateway" {
  vcn_id = oci_core_vcn.project_vcn.id
  compartment_id = oci_identity_compartment.project_compartment.id
  display_name = "${var.project_name} Public Subnet Internet Gateway"
  enabled = true
}

resource "oci_core_route_table" "public_route_table" {
  vcn_id = oci_core_vcn.project_vcn.id
  compartment_id = oci_identity_compartment.project_compartment.id
  display_name = "${var.project_name} Public Subnet Route Table"
  
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.public_internet_gateway.id
  }
}

resource "oci_core_subnet" "public_subnet" {
  vcn_id = oci_core_vcn.project_vcn.id
  compartment_id = oci_identity_compartment.project_compartment.id
  cidr_block = cidrsubnet(var.cidr_block, 1, 1)
  display_name   = "${var.project_name} Public Subnet"
  route_table_id = oci_core_route_table.public_route_table.id
}
