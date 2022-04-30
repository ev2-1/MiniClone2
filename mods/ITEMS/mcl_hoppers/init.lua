-- Downwards hopper (base definition)
local def_hopper = {
	inventory_image = "mcl_hoppers_item.png",
	wield_image = "mcl_hoppers_item.png",
	drawtype = "nodebox",
	paramtype = "light",
	-- FIXME: mcl_hoppers_hopper_inside.png is unused by hoppers.
	tiles = {"mcl_hoppers_hopper_inside.png^mcl_hoppers_hopper_top.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png"},
	node_box = {
		type = "fixed",
		fixed = {
			--funnel walls
			{-0.5, 0.0, 0.4, 0.5, 0.5, 0.5},
			{0.4, 0.0, -0.5, 0.5, 0.5, 0.5},
			{-0.5, 0.0, -0.5, -0.4, 0.5, 0.5},
			{-0.5, 0.0, -0.5, 0.5, 0.5, -0.4},
			--funnel base
			{-0.5, 0.0, -0.5, 0.5, 0.1, 0.5},
			--spout
			{-0.3, -0.3, -0.3, 0.3, 0.0, 0.3},
			{-0.1, -0.3, -0.1, 0.1, -0.5, 0.1},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			--funnel
			{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
			--spout
			{-0.3, -0.3, -0.3, 0.3, 0.0, 0.3},
			{-0.1, -0.3, -0.1, 0.1, -0.5, 0.1},
		},
	},
	is_ground_content = false,
}

local def_hopper_enabled = table.copy(def_hopper)
minetest.register_node("mcl_hoppers:hopper", def_hopper_enabled)

-- Disabled downwards hopper
local def_hopper_disabled = table.copy(def_hopper)
minetest.register_node("mcl_hoppers:hopper_disabled", def_hopper_disabled)

-- Sidewars hopper (base definition)
local def_hopper_side = {
	_doc_items_create_entry = false,
	groups = {pickaxey=1, container=2,not_in_creative_inventory=1,hopper=2},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"mcl_hoppers_hopper_inside.png^mcl_hoppers_hopper_top.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png", "mcl_hoppers_hopper_outside.png"},
	node_box = {
		type = "fixed",
		fixed = {
			--funnel walls
			{-0.5, 0.0, 0.4, 0.5, 0.5, 0.5},
			{0.4, 0.0, -0.5, 0.5, 0.5, 0.5},
			{-0.5, 0.0, -0.5, -0.4, 0.5, 0.5},
			{-0.5, 0.0, -0.5, 0.5, 0.5, -0.4},
			--funnel base
			{-0.5, 0.0, -0.5, 0.5, 0.1, 0.5},
			--spout
			{-0.3, -0.3, -0.3, 0.3, 0.0, 0.3},
			{-0.5, -0.3, -0.1, 0.1, -0.1, 0.1},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			--funnel
			{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
			--spout
			{-0.3, -0.3, -0.3, 0.3, 0.0, 0.3},
			{-0.5, -0.3, -0.1, 0.1, -0.1, 0.1},
		},
	},
	is_ground_content = false,
}

local def_hopper_side_enabled = table.copy(def_hopper_side)
minetest.register_node("mcl_hoppers:hopper_side", def_hopper_side_enabled)

local def_hopper_side_disabled = table.copy(def_hopper_side)
minetest.register_node("mcl_hoppers:hopper_side_disabled", def_hopper_side_disabled)

--[[ END OF NODE DEFINITIONS ]]
