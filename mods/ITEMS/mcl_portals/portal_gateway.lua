local gateway_def = table.copy(minetest.registered_nodes["mcl_portals:portal_end"])
gateway_def.after_destruct = nil
gateway_def.drawtype = "normal"
gateway_def.node_box = nil
gateway_def.walkable = true
gateway_def.tiles[3] = nil
minetest.register_node("mcl_portals:portal_gateway", gateway_def)
