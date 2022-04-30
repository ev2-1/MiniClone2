function mcl_doors:register_door(name, def)
	local box = {{-8/16, -8/16, -8/16, 8/16, 8/16, -5/16}}

	local tt = def.tiles_top
	local tb = def.tiles_bottom

	minetest.register_craftitem(name, {
		inventory_image = def.inventory_image,
	})

	minetest.register_node(name.."_b_1", {
		tiles = {"blank.png", tt[2].."^[transformFXR90", tb[2], tb[2].."^[transformFX", tb[1], tb[1].."^[transformFX"},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_bottom
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_bottom
		},
	})

	minetest.register_node(name.."_t_1", {
		tiles = {tt[2].."^[transformR90", "blank.png", tt[2], tt[2].."^[transformFX", tt[1], tt[1].."^[transformFX"},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_top
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_top
		},
	})

	minetest.register_node(name.."_b_2", {
		tiles = {"blank.png", tt[2].."^[transformFXR90", tb[2].."^[transformI", tb[2].."^[transformFX", tb[1].."^[transformFX", tb[1]},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_bottom
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_bottom
		},
	})

	minetest.register_node(name.."_t_2", {
		tiles = {tt[2].."^[transformR90", "blank.png", tt[2].."^[transformI", tt[2].."^[transformFX", tt[1].."^[transformFX", tt[1]},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_top
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_top
		},
	})
end
