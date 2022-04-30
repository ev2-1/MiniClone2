minetest.register_node("mesecons_commandblock:commandblock_off", {
	tiles = {{name="jeija_commandblock_off.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=2}}},
	is_ground_content = false,
})

minetest.register_node("mesecons_commandblock:commandblock_on", {
	tiles = {{name="jeija_commandblock_off.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=2}}},
	groups = {creative_breakable=1, mesecon_effector_on=1, not_in_creative_inventory=1},
	is_ground_content = false,
})
