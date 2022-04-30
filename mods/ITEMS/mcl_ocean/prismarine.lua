-- Nodes

local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node("mcl_ocean:sea_lantern", {
	paramtype2 = "facedir",
	is_ground_content = false,
	stack_max = 64,
	light_source = minetest.LIGHT_MAX,
	tiles = {{name="mcl_ocean_sea_lantern.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.25}}},
})

minetest.register_node("mcl_ocean:prismarine", {
	is_ground_content = false,
	-- Texture should have 22 frames for smooth transitions.
	tiles = {{name="mcl_ocean_prismarine_anim.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=45.0}}},
})

minetest.register_node("mcl_ocean:prismarine_brick", {
	is_ground_content = false,
	tiles = {"mcl_ocean_prismarine_bricks.png"},
})

minetest.register_node("mcl_ocean:prismarine_dark", {
	is_ground_content = false,
	tiles = {"mcl_ocean_prismarine_dark.png"},
})

-- Craftitems

minetest.register_craftitem("mcl_ocean:prismarine_crystals", {
	inventory_image = "mcl_ocean_prismarine_crystals.png",
})

minetest.register_craftitem("mcl_ocean:prismarine_shard", {
	inventory_image = "mcl_ocean_prismarine_shard.png",
})
