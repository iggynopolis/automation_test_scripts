## Test case 5: update gateway size from t2.micro to t2.small

aws_instance_size     = "t2.small" # t2.micro -> t2.small
aws_ha_gw_size        = "t2.micro"
aws_gateway_tag_list  = []
single_ip_snat        = false
enable_vpc_dns_server = false
