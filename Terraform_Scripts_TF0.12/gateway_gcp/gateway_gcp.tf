resource "aviatrix_gateway" "gcloud_gw" {
  cloud_type      = 4
  account_name    = "GCPAccess"
  gw_name         = "gcloudgw"
  vpc_id          = "gcptestvpc"
  vpc_reg         = "us-west2-a"
  gw_size         = "f1-micro"
  subnet          = "10.168.0.0/20"

  peering_ha_gw_size  = var.gcp_ha_gw_size
  peering_ha_zone     = var.gcp_ha_gw_zone

  allocate_new_eip = true
}
