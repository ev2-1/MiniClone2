--[[
#!#!#!#Cake mod created by Jordan4ibanez#!#!#
#!#!#!#Released under CC Attribution-ShareAlike 3.0 Unported #!#!#
]]--

local cake_texture = {"cake_top.png","cake_bottom.png","cake_inner.png","cake_side.png","cake_side.png","cake_side.png"}
local slice_1 = { -7/16, -8/16, -7/16, -5/16, 0/16, 7/16}
local slice_2 = { -7/16, -8/16, -7/16, -3/16, 0/16, 7/16}
local slice_3 = { -7/16, -8/16, -7/16, -1/16, 0/16, 7/16}
local slice_4 = { -7/16, -8/16, -7/16, 1/16, 0/16, 7/16}
local slice_5 = { -7/16, -8/16, -7/16, 3/16, 0/16, 7/16}
local slice_6 = { -7/16, -8/16, -7/16, 5/16, 0/16, 7/16}

local full_cake = { -7/16, -8/16, -7/16, 7/16, 0/16, 7/16}

minetest.register_node("mcl_cake:cake", {
	tiles = {"cake_top.png","cake_bottom.png","cake_side.png","cake_side.png","cake_side.png","cake_side.png"},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	inventory_image = "cake.png",
	wield_image = "cake.png",
	paramtype = "light",
	is_ground_content = false,
	drawtype = "nodebox",
	selection_box = {
		type = "fixed",
		fixed = full_cake
	},
	node_box = {
		type = "fixed",
		fixed = full_cake
	},
	stack_max = 1,
	drop = "",
})

local register_slice = function(level, nodebox, desc)
	local this = "mcl_cake:cake_"..level
	local after_eat = "mcl_cake:cake_"..(level-1)
	local on_rightclick

	minetest.register_node(this, {
		description = desc,
		tiles = cake_texture,
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
		paramtype = "light",
		is_ground_content = false,
		drawtype = "nodebox",
		selection_box = {
			type = "fixed",
			fixed = nodebox,
		},
		node_box = {
			type = "fixed",
			fixed = nodebox,
			},
		drop = "",
	})

end

register_slice(6, slice_6, "")
register_slice(5, slice_5, "")
register_slice(4, slice_4, "")
register_slice(3, slice_3, "")
register_slice(2, slice_2, "")
register_slice(1, slice_1, "")
