## Test case 2: add tag_list from blank to some values

aws_instance_size     = "t2.micro"
aws_ha_gw_size        = "t2.micro"
aws_gateway_tag_list  = ["k1:v1", "k2:v2"] # added tags
single_ip_snat        = false
enable_vpc_dns_server = false
