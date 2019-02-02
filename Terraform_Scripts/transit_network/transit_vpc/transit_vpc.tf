# Manage Aviatrix Transit Network Gateways

# Create a transit VPC.
# Omit ha_subnet to launch transit VPC without HA.
# HA subnet can later be added or deleted to enable/disable HA in transit VPC

resource "aviatrix_transit_vpc" "test_transit_gw" {
  cloud_type        = "${var.aviatrix_cloud_type_aws}"
  account_name      = "${var.aviatrix_cloud_account_name}"
  gw_name           = "${var.aviatrix_gateway_name}"
  vpc_id            = "${var.aws_vpc_id}"
  vpc_reg           = "${var.aws_region}"
  vpc_size          = "${var.aws_instance}"
  subnet            = "${var.aws_vpc_public_cidr}"
  # dns_server = # (optional) specify DNS IP, only required while using a custom private DNS for the VPC
  # ha_subnet = # (optional) HA subnet. Setting to empty/unset will disable HA. Setting to valid subnet will create an HA gateway in the subnet
  # ha_gw_size = # (optional) HA gw size. Mandatory if HA is enabled (ex. "t2.micro")
  tag_list = ["key1:value1", "key2:value2"] # (optional) instance tag of cloud provider
  # enable_hybrid_connection = true # (optional) sign of readiness for TGW connection (ex. false)
}
