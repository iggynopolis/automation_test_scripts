## Test case 3: update GW size

arm_gw_size       = "Standard_B1ms" # Standard_B1s -> B1ms
arm_ha_gw_size    = "Standard_B1ms" # Standard_B1s -> B1ms

toggle_snat       = "yes"

tgw_enable_hybrid             = false # not supported in Azure yet (18 apr)
tgw_enable_connected_transit  = "no" # yes -> no
