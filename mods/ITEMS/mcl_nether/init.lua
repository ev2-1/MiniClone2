minetest.register_node("mcl_nether:glowstone", {
	tiles = {"mcl_nether_glowstone.png"},
	is_ground_content = true,
	paramtype = "light",
	light_source = minetest.LIGHT_MAX,
})

minetest.register_node("mcl_nether:quartz_ore", {
	tiles = {"mcl_nether_quartz_ore.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_nether:netherrack", {
	tiles = {"mcl_nether_netherrack.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_nether:magma", {
	tiles = {{name="mcl_nether_magma.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.5}}},
	is_ground_content = true,
})

minetest.register_node("mcl_nether:soul_sand", {
	tiles = {"mcl_nether_soul_sand.png"},
	is_ground_content = true,
	collision_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5 - 2/16, 0.5 },
	},
})

minetest.register_node("mcl_nether:nether_brick", {
	tiles = {"mcl_nether_nether_brick.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_nether:red_nether_brick", {
	tiles = {"mcl_nether_red_nether_brick.png"},
	is_ground_content = false,
})


minetest.register_node("mcl_nether:nether_wart_block", {
	tiles = {"mcl_nether_nether_wart_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_nether:quartz_block", {
	is_ground_content = false,
	tiles = {"mcl_nether_quartz_block_top.png", "mcl_nether_quartz_block_bottom.png", "mcl_nether_quartz_block_side.png"},
})

minetest.register_node("mcl_nether:quartz_chiseled", {
	is_ground_content = false,
	tiles = {"mcl_nether_quartz_chiseled_top.png", "mcl_nether_quartz_chiseled_top.png", "mcl_nether_quartz_chiseled_side.png"},
})

minetest.register_node("mcl_nether:quartz_pillar", {
	paramtype2 = "facedir",
	is_ground_content = false,
	tiles = {"mcl_nether_quartz_pillar_top.png", "mcl_nether_quartz_pillar_top.png", "mcl_nether_quartz_pillar_side.png"},
})
minetest.register_node("mcl_nether:quartz_smooth", {
	is_ground_content = false,
	tiles = {"mcl_nether_quartz_block_bottom.png"},
})

dofile(minetest.get_modpath(minetest.get_current_modname()).."/nether_wart.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/lava.lua")
