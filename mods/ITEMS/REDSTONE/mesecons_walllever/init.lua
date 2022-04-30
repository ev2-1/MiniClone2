-- LEVER
minetest.register_node("mesecons_walllever:wall_lever_off", {
	drawtype = "mesh",
	tiles = {
		"jeija_wall_lever_lever_light_on.png",
	},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	inventory_image = "jeija_wall_lever.png",
	wield_image = "jeija_wall_lever.png",
	paramtype = "light",
	paramtype2 = "facedir",
	mesh = "jeija_wall_lever_off.obj",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -3/16, -4/16, 2/16, 3/16, 4/16, 8/16 },
	},
	is_ground_content = false,
})

minetest.register_node("mesecons_walllever:wall_lever_on", {
	drawtype = "mesh",
	tiles = {
		"jeija_wall_lever_lever_light_on.png",
	},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	paramtype = "light",
	paramtype2 = "facedir",
	mesh = "jeija_wall_lever_on.obj",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -3/16, -4/16, 2/16, 3/16, 4/16, 8/16 },
	},
	is_ground_content = false,
})

minetest.register_craft({
	output = "mesecons_walllever:wall_lever_off",
	recipe = {
		{"mcl_core:stick"},
		{"mcl_core:cobble"},
	}
})

if minetest.get_modpath("doc") then
	doc.add_entry_alias("nodes", "mesecons_walllever:wall_lever_off", "nodes", "mesecons_walllever:wall_lever_on")
end
