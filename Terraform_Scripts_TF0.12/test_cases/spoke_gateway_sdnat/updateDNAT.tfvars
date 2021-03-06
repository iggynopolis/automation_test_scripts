# SNAT
aws_snat_policy_src_ip        = "21.0.0.0/24"
aws_snat_policy_src_port      = 53
aws_snat_policy_dst_ip        = "22.0.0.0/24"
aws_snat_policy_dst_port      = 54
aws_snat_policy_protocol      = "udp"
aws_snat_policy_interface     = "eth0"
aws_snat_policy_connection    = "None"
aws_snat_policy_mark          = 71
aws_snat_policy_new_src_ip    = "23.0.0.0"
aws_snat_policy_new_src_port  = 55

arm_snat_policy_src_ip        = "21.0.0.0/24"
arm_snat_policy_src_port      = 53
arm_snat_policy_dst_ip        = "22.0.0.0/24"
arm_snat_policy_dst_port      = 54
arm_snat_policy_protocol      = "tcp"
arm_snat_policy_interface     = "eth0"
arm_snat_policy_connection    = "None"
arm_snat_policy_mark          = 71
arm_snat_policy_new_src_ip    = "23.0.0.0"
arm_snat_policy_new_src_port  = 55

# DNAT
aws_dnat_policy_src_ip        = "21.0.0.0/24"
aws_dnat_policy_src_port      = 53
aws_dnat_policy_dst_ip        = "22.0.0.0/24"
aws_dnat_policy_dst_port      = 54
aws_dnat_policy_protocol      = "tcp"
aws_dnat_policy_interface     = "eth0"
aws_dnat_policy_connection    = "None"
aws_dnat_policy_mark          = 71
aws_dnat_policy_new_src_ip    = "23.0.0.0"
aws_dnat_policy_new_src_port  = 55

arm_dnat_policy_src_ip        = "21.0.0.0/24"
arm_dnat_policy_src_port      = 53
arm_dnat_policy_dst_ip        = "22.0.0.0/24"
arm_dnat_policy_dst_port      = 54
arm_dnat_policy_protocol      = "udp"
arm_dnat_policy_interface     = "eth0"
arm_dnat_policy_connection    = "None"
arm_dnat_policy_mark          = 71
arm_dnat_policy_new_src_ip    = "23.0.0.0"
arm_dnat_policy_new_src_port  = 55
