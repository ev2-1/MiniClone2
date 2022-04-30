--[[ This mod registers 3 nodes:
- One node for the horizontal-facing dropper (mcl_droppers:dropper)
- One node for the upwards-facing droppers (mcl_droppers:dropper_up)
- One node for the downwards-facing droppers (mcl_droppers:dropper_down)

3 node definitions are needed because of the way the textures are defined.
All node definitions share a lot of code, so this is the reason why there
are so many weird tables below.
]]

-- Shared core definition table
local dropperdef = {
	is_ground_content = false,
	sounds = mcl_sounds.node_sound_stone_defaults(),
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta:to_table()
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return count
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
}

-- Horizontal dropper

local horizontal_def = table.copy(dropperdef)
function horizontal_def.after_place_node(pos, placer, itemstack, pointed_thing)
	setup_dropper(pos)
	orientate_dropper(pos, placer)
end
horizontal_def.tiles = {
	"default_furnace_top.png", "default_furnace_bottom.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "mcl_droppers_dropper_front_horizontal.png"
}
horizontal_def.paramtype2 = "facedir"
horizontal_def.groups = {pickaxey=1, container=2, material_stone=1}

minetest.register_node("mcl_droppers:dropper", horizontal_def)

-- Down dropper
local down_def = table.copy(dropperdef)
down_def.after_place_node = setup_dropper
down_def.tiles = {
	"default_furnace_top.png", "mcl_droppers_dropper_front_vertical.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "default_furnace_side.png"
}
down_def.groups = {pickaxey=1, container=2,not_in_creative_inventory=1, material_stone=1}
down_def._doc_items_create_entry = false
down_def.drop = "mcl_droppers:dropper"
minetest.register_node("mcl_droppers:dropper_down", down_def)

-- Up dropper
-- The up dropper is almost identical to the down dropper, it only differs in textures
local up_def = table.copy(down_def)
up_def.tiles = {
	"mcl_droppers_dropper_front_vertical.png", "default_furnace_bottom.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "default_furnace_side.png"
}
minetest.register_node("mcl_droppers:dropper_up", up_def)



-- Ladies and gentlemen, I present to you: the crafting recipe!
minetest.register_craft({
	output = "mcl_droppers:dropper",
	recipe = {
		{"mcl_core:cobble", "mcl_core:cobble", "mcl_core:cobble",},
		{"mcl_core:cobble", "", "mcl_core:cobble",},
		{"mcl_core:cobble", "mesecons:redstone", "mcl_core:cobble",},
	}
})
