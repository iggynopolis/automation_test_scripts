## Manages the vpn_connection of the Aviatrix TGW resource
## dependent on aws_tgw_testing case

## Dynamic connection
resource "aviatrix_aws_tgw_vpn_conn" "test_aws_tgw_vpn_conn1" {
  tgw_name             = "test-aws-tgw"
  route_domain_name    = "Shared_Service_Domain"
  connection_name      = "tgw_vpn_conn1"
  connection_type      = "dynamic"
  public_ip            = "69.0.0.0"
  remote_as_number     = "1234"

  # optional custom tunnel options
  inside_ip_cidr_tun_1 = "169.254.69.69/30" # A /30 CIDR in 169.254.0.0/16
  pre_shared_key_tun_1 = "abc_123.def" # A 8-64 character string with alphanumeric, underscore(_) and dot(.). It cannot start with 0.
  inside_ip_cidr_tun_2 = "169.254.70.70/30"
  pre_shared_key_tun_2 = "def_456.ghi"
}

## Static connection
resource "aviatrix_aws_tgw_vpn_conn" "test_aws_tgw_vpn_conn2" {
  tgw_name             = "test-aws-tgw"
  route_domain_name    = "Default_Domain"
  connection_name      = "tgw_vpn_conn2"
  connection_type      = "static"
  public_ip            = "70.0.0.0"
  remote_cidr          = "10.0.0.0/16,10.1.0.0/16"
}

output "test_aws_tgw_vpn_conn1_id" {
  value = aviatrix_aws_tgw_vpn_conn.test_aws_tgw_vpn_conn1.id
}

output "test_aws_tgw_vpn_conn2_id" {
  value = aviatrix_aws_tgw_vpn_conn.test_aws_tgw_vpn_conn2.id
}
