## Test case 3: update GW size

arm_gw_size       = "Standard_D4_v2" # Standard_B1s -> B1ms
arm_ha_gw_size    = "Standard_D5_v2"

toggle_snat       = true
single_az_ha      = true # false -> true

tgw_enable_hybrid             = false # not supported in Azure yet (18 apr)
tgw_enable_connected_transit  = false # true -> false
