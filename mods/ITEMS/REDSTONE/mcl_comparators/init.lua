-- compute tile depending on state and mode
local function get_tiles(state, mode)
	local top = "mcl_comparators_"..state..".png^"..
		"mcl_comparators_"..mode..".png"
	local sides = "mcl_comparators_sides_"..state..".png^"..
		"mcl_comparators_sides_"..mode..".png"
	local ends = "mcl_comparators_ends_"..state..".png^"..
		"mcl_comparators_ends_"..mode..".png"
	return {
		top, "mcl_stairs_stone_slab_top.png",
		sides, sides.."^[transformFX",
		ends, ends,
	}
end

local icon = "mcl_comparators_item.png"

local node_boxes = {
	comp = {
		{ -8/16, -8/16, -8/16,
		   8/16, -6/16,  8/16 },	-- the main slab
		{ -1/16, -6/16,  6/16,
		   1/16, -4/16,  4/16 },	-- front torch
		{ -4/16, -6/16, -5/16,
		  -2/16, -1/16, -3/16 },	-- left back torch
		{  2/16, -6/16, -5/16,
		   4/16, -1/16, -3/16 },	-- right back torch
	},
	sub = {
		{ -8/16, -8/16, -8/16,
		   8/16, -6/16,  8/16 },	-- the main slab
		{ -1/16, -6/16,  6/16,
		   1/16, -3/16,  4/16 },	-- front torch (active)
		{ -4/16, -6/16, -5/16,
		  -2/16, -1/16, -3/16 },	-- left back torch
		{  2/16, -6/16, -5/16,
		   4/16, -1/16, -3/16 },	-- right back torch
	},
}

local collision_box = {
	type = "fixed",
	fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
}

for _, mode in pairs{"comp", "sub"} do
	for _, state in pairs{"on", "off"} do
		local state_str = state
		local nodename =
			"mcl_comparators:comparator_"..state_str.."_"..mode

		-- Help
		local longdesc, usagehelp, use_help
		use_help = false

		local nodedef = {
			inventory_image = icon,
			wield_image = icon,
			drawtype = "nodebox",
			tiles = get_tiles(state_str, mode),
			use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
			walkable = true,
			selection_box = collision_box,
			collision_box = collision_box,
			node_box = {
				type = "fixed",
				fixed = node_boxes[mode],
			},
			groups = groups,
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = false,
			is_ground_content = false,
			drop = "mcl_comparators:comparator_off_comp",
		}

		if mode == "comp" and state == "off" then
			-- This is the prototype
			nodedef._doc_items_create_entry = true
		else
			if mode == "sub" or state == "on" then
				nodedef.inventory_image = nil
			end
		end

		minetest.register_node(nodename, nodedef)
		mcl_wip.register_wip_item(nodename)
	end
end
