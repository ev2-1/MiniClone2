local anvilbox = {
	type = "fixed",
	fixed = {
		{ -8 / 16, -8 / 16, -6 / 16, 8 / 16, 8 / 16, 6 / 16 },
	},
}
local anvildef = {
	groups = {pickaxey=1, falling_node=1, falling_node_damage=1, crush_after_fall=1, deco_block=1, anvil=1},
	tiles = {"mcl_anvils_anvil_top_damaged_0.png^[transformR90", "mcl_anvils_anvil_base.png", "mcl_anvils_anvil_side.png"},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -6 / 16, -8 / 16, -6 / 16, 6 / 16, -4 / 16, 6 / 16 },
			{ -5 / 16, -4 / 16, -4 / 16, 5 / 16, -3 / 16, 4 / 16 },
			{ -4 / 16, -3 / 16, -2 / 16, 4 / 16, 2 / 16, 2 / 16 },
			{ -8 / 16, 2 / 16, -5 / 16, 8 / 16, 8 / 16, 5 / 16 },
		}
	},
	selection_box = anvilbox,
	collision_box = anvilbox,
}

local anvildef0 = table.copy(anvildef)

local anvildef1 = table.copy(anvildef)
anvildef1._doc_items_create_entry = false
anvildef1.groups.anvil = 2
anvildef1._doc_items_create_entry = false
anvildef1.tiles = {"mcl_anvils_anvil_top_damaged_1.png^[transformR90", "mcl_anvils_anvil_base.png", "mcl_anvils_anvil_side.png"}

local anvildef2 = table.copy(anvildef)
anvildef2._doc_items_create_entry = false
anvildef2.groups.anvil = 3
anvildef2._doc_items_create_entry = false
anvildef2.tiles = {"mcl_anvils_anvil_top_damaged_2.png^[transformR90", "mcl_anvils_anvil_base.png", "mcl_anvils_anvil_side.png"}

minetest.register_node("mcl_anvils:anvil", anvildef0)
minetest.register_node("mcl_anvils:anvil_damage_1", anvildef1)
minetest.register_node("mcl_anvils:anvil_damage_2", anvildef2)
