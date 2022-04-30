local off_def = {
	name = "mesecon_torch_off",
	doc_items_create_entry = false,
	icon = "jeija_torches_off.png",
	tiles = {"jeija_torches_off.png"},
	light = 0,
	groups = {dig_immediate=3, dig_by_water=1, redstone_torch=2, mesecon_ignore_opaque_dig=1, not_in_creative_inventory=1},
	sounds = mcl_sounds.node_sound_wood_defaults(),
	drop = "mesecons_torch:mesecon_torch_on",
}

mcl_torches.register_torch(off_def)

local overheated_def = table.copy(off_def)
mcl_torches.register_torch(overheated_def)

local on_def = {
	name = "mesecon_torch_on",
	icon = "jeija_torches_on.png",
	tiles = {"jeija_torches_on.png"},
	light = 7,
}

mcl_torches.register_torch(on_def)

local on_override = {
	on_destruct = function(pos, oldnode)
		local node = minetest.get_node(pos)
	end,
}

minetest.override_item("mesecons_torch:mesecon_torch_on", on_override)
minetest.override_item("mesecons_torch:mesecon_torch_on_wall", on_override)

minetest.register_node("mesecons_torch:redstoneblock", {
	tiles = {"redstone_redstone_block.png"},
	is_ground_content = false,
})
