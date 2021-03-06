## Creates and manages a Aviatrix Site2Cloud connections

# environment
resource "random_integer" "vpc1_cidr_int" {
  count = 2
  min = 1
  max = 223
}
resource "random_integer" "vpc2_cidr_int" {
  count = 2
  min = 1
  max = 223
}
resource "random_integer" "vpc3_cidr_int" {
  count = 2
  min = 1
  max = 223
}

resource "aviatrix_vpc" "aws_s2c_vpc_1" {
  account_name          = "AWSAccess"
  aviatrix_transit_vpc  = false
  aviatrix_firenet_vpc  = false
  cidr                  = join(".", [random_integer.vpc1_cidr_int[0].result, random_integer.vpc1_cidr_int[1].result, "0.0/16"])
  cloud_type            = 1
  name                  = "aws-s2c-vpc-1"
  region                = "us-east-1"
}
resource "aviatrix_vpc" "aws_s2c_vpc_2" {
  account_name          = "AWSAccess"
  aviatrix_transit_vpc  = false
  aviatrix_firenet_vpc  = false
  cidr                  = join(".", [random_integer.vpc2_cidr_int[0].result, random_integer.vpc2_cidr_int[1].result, "0.0/16"])
  cloud_type            = 1
  name                  = "aws-s2c-vpc-2"
  region                = "us-east-1"
}
resource "aviatrix_vpc" "aws_s2c_vpc_3" {
  account_name          = "AWSAccess"
  aviatrix_transit_vpc  = false
  aviatrix_firenet_vpc  = false
  cidr                  = join(".", [random_integer.vpc3_cidr_int[0].result, random_integer.vpc3_cidr_int[1].result, "0.0/16"])
  cloud_type            = 1
  name                  = "aws-s2c-vpc-3"
  region                = "us-east-1"
}

resource "aws_eip" "eip_gw_1" {
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_eip" "eip_gw_1_ha" {
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_eip" "eip_gw_2" {
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_eip" "eip_gw_2_ha" {
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_eip" "eip_gw_3" {
  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_eip" "eip_gw_3_ha" {
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_vpn_gateway" "s2c_us_east_vgw" {
  amazon_side_asn = 64512
  tags = {
    Name = "s2c-us-east-vgw"
  }
  vpc_id = aviatrix_vpc.aws_s2c_vpc_1.vpc_id
}

data "aws_route_table" "aws_s2c_vpc_1_rtb" {
  vpc_id      = aviatrix_vpc.aws_s2c_vpc_1.vpc_id
  subnet_id   = aviatrix_vpc.aws_s2c_vpc_1.subnets.6.subnet_id
}

# Create Aviatrix AWS gateway to act as our "Local"
resource "aviatrix_gateway" "test_gateway1" {
  cloud_type          = 1
  account_name        = "AWSAccess"
  gw_name             = "avxPrimaryGwName"
  vpc_id              = aviatrix_vpc.aws_s2c_vpc_1.vpc_id
  vpc_reg             = aviatrix_vpc.aws_s2c_vpc_1.region
  gw_size             = "t2.micro"
  subnet              = aviatrix_vpc.aws_s2c_vpc_1.subnets.6.cidr

  peering_ha_subnet   = aviatrix_vpc.aws_s2c_vpc_1.subnets.7.cidr
  peering_ha_gw_size  = "t2.micro"

  allocate_new_eip    = false
  eip                 = aws_eip.eip_gw_1.public_ip
  peering_ha_eip      = aws_eip.eip_gw_1_ha.public_ip
}

# Create Aviatrix AWS gateway to act as our on-prem / "Remote" server
resource "aviatrix_gateway" "test_gateway2" {
  cloud_type          = 1
  account_name        = "AWSAccess"
  gw_name             = "onPremRemoteGW"
  vpc_id              = aviatrix_vpc.aws_s2c_vpc_2.vpc_id
  vpc_reg             = aviatrix_vpc.aws_s2c_vpc_2.region
  gw_size             = "t2.micro"
  subnet              = aviatrix_vpc.aws_s2c_vpc_2.subnets.6.cidr

  peering_ha_subnet   = aviatrix_vpc.aws_s2c_vpc_2.subnets.7.cidr
  peering_ha_gw_size  = "t2.micro"

  allocate_new_eip    = false
  eip                 = aws_eip.eip_gw_2.public_ip
  peering_ha_eip      = aws_eip.eip_gw_2_ha.public_ip
}

## Test case: with 3 gateways/ more than 2 connections
resource "aviatrix_gateway" "test_gateway3" {
  cloud_type          = 1
  account_name        = "AWSAccess"
  gw_name             = "gateway3"
  vpc_id              = aviatrix_vpc.aws_s2c_vpc_3.vpc_id
  vpc_reg             = aviatrix_vpc.aws_s2c_vpc_3.region
  gw_size             = "t2.micro"
  subnet              = aviatrix_vpc.aws_s2c_vpc_3.subnets.6.cidr

  peering_ha_subnet   = aviatrix_vpc.aws_s2c_vpc_3.subnets.7.cidr
  peering_ha_gw_size  = "t2.micro"

  allocate_new_eip    = false
  eip                 = aws_eip.eip_gw_3.public_ip
  peering_ha_eip      = aws_eip.eip_gw_3_ha.public_ip
}

#################################################

resource "aviatrix_site2cloud" "s2c_test" {
  vpc_id                        = aviatrix_gateway.test_gateway1.vpc_id
  connection_name               = "s2c_test_conn_name"
  connection_type               = "unmapped"
  remote_gateway_type           = var.custom_alg == true ? "generic" : "avx"
  tunnel_type                   = "udp"
  ha_enabled                    = true

  primary_cloud_gateway_name    = aviatrix_gateway.test_gateway1.gw_name
  backup_gateway_name           = join("-", [aviatrix_gateway.test_gateway1.gw_name, "hagw"])
  remote_gateway_ip             = aviatrix_gateway.test_gateway2.eip
  backup_remote_gateway_ip      = aviatrix_gateway.test_gateway2.peering_ha_eip

  # pre_shared_key = var.pre_shared_key # (Optional) Auto-generated if not specified
  # backup_pre_shared_key = var.pre_shared_key_backup # (Optional)

  remote_subnet_cidr            = aviatrix_gateway.test_gateway2.subnet
  local_subnet_cidr             = aviatrix_gateway.test_gateway1.subnet

  # ssl_server_pool               = "192.168.45.0/24"
  enable_dead_peer_detection    = true

  ## mapped testing ##
  private_route_encryption      = var.custom_alg == true ? true : false
  route_table_list              = var.custom_alg == true ? [data.aws_route_table.aws_s2c_vpc_1_rtb.id] : null
  remote_gateway_latitude       = var.custom_alg == true ? 39.0437 : null
  remote_gateway_longitude      = var.custom_alg == true ? -77.4875 : null
  backup_remote_gateway_latitude = var.custom_alg == true ? 39.0437 : null
  backup_remote_gateway_longitude = var.custom_alg == true ? -77.4875 : null

  depends_on                    = ["aviatrix_gateway.test_gateway1", "aviatrix_gateway.test_gateway2", "aviatrix_gateway.test_gateway3"]
}

resource "aviatrix_site2cloud" "s2c_test2" {
  vpc_id                        = aviatrix_gateway.test_gateway2.vpc_id
  connection_name               = "s2c_test_conn_name_2"
  connection_type               = "unmapped"
  remote_gateway_type           = var.custom_alg == true ? "generic" : "avx"
  tunnel_type                   = "udp"
  ha_enabled                    = true

  primary_cloud_gateway_name    = aviatrix_gateway.test_gateway2.gw_name
  backup_gateway_name           = join("-", [aviatrix_gateway.test_gateway2.gw_name, "hagw"])
  remote_gateway_ip             = aviatrix_gateway.test_gateway1.eip
  backup_remote_gateway_ip      = aviatrix_gateway.test_gateway1.peering_ha_eip

  pre_shared_key                = var.pre_shared_key
  backup_pre_shared_key         = var.pre_shared_key_backup

  remote_subnet_cidr            = aviatrix_gateway.test_gateway1.subnet
  local_subnet_cidr             = aviatrix_gateway.test_gateway2.subnet

  # ssl_server_pool               = "192.168.45.0/24"
  enable_dead_peer_detection    = true

  depends_on                    = ["aviatrix_site2cloud.s2c_test"]
}

resource "aviatrix_site2cloud" "s2c_test3" {
  vpc_id                        = aviatrix_gateway.test_gateway3.vpc_id
  connection_name               = "s2c_test_conn_name_3"
  connection_type               = var.custom_alg == true ? "mapped" : "unmapped"
  remote_gateway_type           = var.custom_alg == true ? "generic" : "avx"
  tunnel_type                   = "udp"
  ha_enabled                    = true

  primary_cloud_gateway_name    = aviatrix_gateway.test_gateway3.gw_name
  backup_gateway_name           = join("-", [aviatrix_gateway.test_gateway3.gw_name, "hagw"])
  remote_gateway_ip             = aviatrix_gateway.test_gateway1.eip
  backup_remote_gateway_ip      = aviatrix_gateway.test_gateway1.peering_ha_eip

  remote_subnet_cidr            = aviatrix_gateway.test_gateway2.subnet
  local_subnet_cidr             = aviatrix_gateway.test_gateway3.subnet

  ## mapped testing ##
  remote_subnet_virtual         = var.custom_alg == true ? aviatrix_gateway.test_gateway2.subnet : null
  local_subnet_virtual          = var.custom_alg == true ? "100.1.0.0/20" : null

  custom_algorithms             = var.custom_alg
  phase_1_authentication        = var.custom_alg == true ? "SHA-512" : null
  phase_1_dh_groups             = var.custom_alg == true ? "1" : null
  phase_1_encryption            = var.custom_alg == true ? "AES-192-CBC" : null
  phase_2_authentication        = var.custom_alg == true ? "HMAC-SHA-512" : null
  phase_2_dh_groups             = var.custom_alg == true ? "1" : null
  phase_2_encryption            = var.custom_alg == true ? "AES-192-CBC" : null

  # ssl_server_pool               = "192.168.45.0/24"
  enable_dead_peer_detection    = false

  depends_on                    = ["aviatrix_site2cloud.s2c_test2"]
}

resource "aviatrix_site2cloud" "s2c_test4" {
  vpc_id                        = aviatrix_gateway.test_gateway1.vpc_id
  connection_name               = "s2c_test_conn_name_4"
  connection_type               = var.custom_alg == true ? "mapped" : "unmapped"
  remote_gateway_type           = var.custom_alg == true ? "generic" : "avx"
  tunnel_type                   = "udp"
  ha_enabled                    = true

  primary_cloud_gateway_name    = aviatrix_gateway.test_gateway1.gw_name
  backup_gateway_name           = join("-", [aviatrix_gateway.test_gateway1.gw_name, "hagw"])
  remote_gateway_ip             = aviatrix_gateway.test_gateway3.eip
  backup_remote_gateway_ip      = aviatrix_gateway.test_gateway3.peering_ha_eip

  remote_subnet_cidr            = aviatrix_gateway.test_gateway3.subnet
  local_subnet_cidr             = aviatrix_gateway.test_gateway2.subnet

  remote_subnet_virtual         = var.custom_alg == true ? "100.1.0.0/20" : null
  local_subnet_virtual          = var.custom_alg == true ? aviatrix_gateway.test_gateway2.subnet : null

  custom_algorithms             = var.custom_alg
  phase_1_authentication        = var.custom_alg == true ? "SHA-384" : null
  phase_1_dh_groups             = var.custom_alg == true ? "16" : null
  phase_1_encryption            = var.custom_alg == true ? "3DES" : null
  phase_2_authentication        = var.custom_alg == true ? "HMAC-SHA-384" : null
  phase_2_dh_groups             = var.custom_alg == true ? "16" : null
  phase_2_encryption            = var.custom_alg == true ? "3DES" : null

  # ssl_server_pool               = "192.168.45.0/24"
  enable_dead_peer_detection    = false

  depends_on = ["aviatrix_site2cloud.s2c_test3"]
}

#################################################
# Outputs
#################################################

output "s2c_test_id" {
  value = aviatrix_site2cloud.s2c_test.id
}

output "s2c_test2_id" {
  value = aviatrix_site2cloud.s2c_test2.id
}

output "s2c_test3_id" {
  value = aviatrix_site2cloud.s2c_test3.id
}

output "s2c_test4_id" {
  value = aviatrix_site2cloud.s2c_test4.id
}
