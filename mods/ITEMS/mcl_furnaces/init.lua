local LIGHT_ACTIVE_FURNACE = 13

minetest.register_node("mcl_furnaces:furnace", {
	_doc_items_hidden = false,
	tiles = {
		"default_furnace_top.png", "default_furnace_bottom.png",
		"default_furnace_side.png", "default_furnace_side.png",
		"default_furnace_side.png", "default_furnace_front.png"
	},
	paramtype2 = "facedir",
	is_ground_content = false,
})

minetest.register_node("mcl_furnaces:furnace_active", {
	_doc_items_create_entry = false,
	tiles = {
		"default_furnace_top.png", "default_furnace_bottom.png",
		"default_furnace_side.png", "default_furnace_side.png",
		"default_furnace_side.png", "default_furnace_front_active.png",
	},
	paramtype2 = "facedir",
	paramtype = "light",
	is_ground_content = false,
})
