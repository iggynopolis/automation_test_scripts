# empty creation

## Use variations of commenting out the top and bottom portion of this file to test individual/ combinations of emptyinvalid + valid input
## Please see Mantis: id=8063 for ICMP port issue

## VALID INPUTS
# aviatrix_gateway_name             = "firewallGW"
# aviatrix_firewall_base_policy     = "allow-all"
# aviatrix_firewall_packet_logging  = "on"
#
# aviatrix_firewall_policy_protocol         = ["tcp", "udp", "sctp", "rdp", "dccp", "all"]
# aviatrix_firewall_policy_source_ip        = ["10.10.10.10/32", "12.12.12.12/32", "14.14.14.14/32", "16.16.16.16/32", "18.18.18.18/32", "20.20.20.20/32"]
# aviatrix_firewall_policy_log_enable       = ["on", "off"] # Use 0 or 1 for enabling packet logging
# aviatrix_firewall_policy_destination_ip   = ["11.11.11.11/32", "13.13.13.13/32", "15.15.15.15/32", "17.17.17.17/32", "19.19.19.19/32", "21.21.21.21/32"]
# aviatrix_firewall_policy_action           = ["allow", "deny"] # Use 0 or 1 for allow or deny policy action
# aviatrix_firewall_policy_port             = ["69", "0:65535", "25:420", "420", "65535", "0:65535"]

##############################################
## EMPTY / INVALID ICMP
##############################################
## (run in conjunction with ICMP case (Case 2) in firewall_icmp.tf)

aviatrix_gateway_name             = ""
aviatrix_firewall_base_policy     = ""
aviatrix_firewall_packet_logging  = ""

aviatrix_firewall_policy_protocol         = [""]
aviatrix_firewall_policy_source_ip        = [""]
aviatrix_firewall_policy_log_enable       = ["", ""] # Use 0 or 1 for enabling packet logging
aviatrix_firewall_policy_destination_ip   = [""]
aviatrix_firewall_policy_action           = ["", ""] # Use 0 or 1 for allow or deny policy action
aviatrix_firewall_policy_port             = [""]
