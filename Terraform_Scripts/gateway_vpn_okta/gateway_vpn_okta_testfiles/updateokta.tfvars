## Test case 1. Changes Okta-related parameter values
## Please see Mantis id = 8142

aviatrix_controller_ip          = "1.2.3.4"
aviatrix_controller_username    = "admin"
aviatrix_controller_password    = "password"
##############################################

                       aws_region = "us-east-1"
                       aws_vpc_id = "vpc-abc123"
                     aws_instance = "t2.micro"
              aws_vpc_public_cidr = "10.0.0.0/24"

     aviatrix_cloud_account_name  = "PrimaryAccessAccount"
           aviatrix_gateway_name  = "myAviatrix-gateway-VPN-ldap-duo"
          aviatrix_cloud_type_aws = 1

              aviatrix_vpn_access = "yes"
                aviatrix_vpn_cidr = "192.168.230.0/24"
                 aviatrix_vpn_elb = "yes"
        aviatrix_vpn_split_tunnel = "yes"
            aviatrix_vpn_otp_mode = "3"
##############################################
## This is the section you're concerned with
          aviatrix_vpn_okta_token = "kenTTTTTTTTTTTTTTTTTTTTTTTTOOOOOOOOooooooo"
            aviatrix_vpn_okta_url = "https://api-4567.okta.com"
aviatrix_vpn_okta_username_suffix = "xxXXXXXXXXXxxxxsuff"
##############################################
