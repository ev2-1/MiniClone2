for i = 1, 4 do
	local boxes
	if i == 1 then
		boxes = {
			{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },		-- the main slab
			{ -1/16, -6/16, 6/16, 1/16, -1/16, 4/16},     -- still torch
			{ -1/16, -6/16, 0/16, 1/16, -1/16, 2/16},     -- moved torch
		}
	elseif i == 2 then
		boxes = {
			{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },		-- the main slab
			{ -1/16, -6/16, 6/16, 1/16, -1/16, 4/16},     -- still torch
			{ -1/16, -6/16, -2/16, 1/16, -1/16, 0/16},     -- moved torch
		}
	elseif i == 3 then
		boxes = {
			{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },		-- the main slab
			{ -1/16, -6/16, 6/16, 1/16, -1/16, 4/16},     -- still torch
			{ -1/16, -6/16, -4/16, 1/16, -1/16, -2/16},     -- moved torch
		}
	elseif i == 4 then
		boxes = {
			{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },		-- the main slab
			{ -1/16, -6/16, 6/16, 1/16, -1/16, 4/16},     -- still torch
			{ -1/16, -6/16, -6/16, 1/16, -1/16, -4/16},     -- moved torch
		}
	end

	local help, tt, longdesc, usagehelp, icon, on_construct
	if i == 1 then
		help = true
		icon = "mesecons_delayer_item.png"
	else
		help = false
	end

	minetest.register_node("mesecons_delayer:delayer_off_"..tostring(i), {
		inventory_image = icon,
		wield_image = icon,
		drawtype = "nodebox",
		tiles = {
			"mesecons_delayer_off.png",
			"mcl_stairs_stone_slab_top.png",
			"mesecons_delayer_sides_off.png",
			"mesecons_delayer_sides_off.png",
			"mesecons_delayer_ends_off.png",
			"mesecons_delayer_ends_off.png",
		},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
		--wield_image = "mesecons_delayer_off.png",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
		},
		collision_box = {
			type = "fixed",
			fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
		},
		node_box = {
			type = "fixed",
			fixed = boxes
		},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = false,
	})

	minetest.register_node("mesecons_delayer:delayer_on_"..tostring(i), {
		drawtype = "nodebox",
		tiles = {
			"mesecons_delayer_on.png",
			"mcl_stairs_stone_slab_top.png",
			"mesecons_delayer_sides_on.png",
			"mesecons_delayer_sides_on.png",
			"mesecons_delayer_ends_on.png",
			"mesecons_delayer_ends_on.png",
		},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
		},
		collision_box = {
			type = "fixed",
			fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
		},
		node_box = {
			type = "fixed",
			fixed = boxes
		},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = false,
		is_ground_content = false,
	})
end


-- Locked repeater

minetest.register_node("mesecons_delayer:delayer_off_locked", {
	drawtype = "nodebox",
	-- FIXME: Textures of torch and the lock bar overlap. Nodeboxes are (sadly) not suitable for this.
	-- So this needs to be turned into a mesh.
	tiles = {
		"mesecons_delayer_locked_off.png",
		"mcl_stairs_stone_slab_top.png",
		"mesecons_delayer_sides_locked_off.png",
		"mesecons_delayer_sides_locked_off.png",
		"mesecons_delayer_front_locked_off.png",
		"mesecons_delayer_end_locked_off.png",
	},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	wield_image = "mesecons_delayer_locked_off.png",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
	},
	collision_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 }, -- the main slab
			{ -1/16, -6/16, 6/16, 1/16, -1/16, 4/16}, -- still torch
			{ -6/16, -6/16, -1/16, 6/16, -4/16, 1/16}, -- lock
		}
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = false,
	is_ground_content = false,
})

minetest.register_node("mesecons_delayer:delayer_on_locked", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_delayer_locked_on.png",
		"mcl_stairs_stone_slab_top.png",
		"mesecons_delayer_sides_locked_on.png",
		"mesecons_delayer_sides_locked_on.png",
		"mesecons_delayer_front_locked_on.png",
		"mesecons_delayer_end_locked_on.png",
	},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
	},
	collision_box = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 },
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 }, -- the main slab
			{ -1/16, -6/16, 6/16, 1/16, -1/16, 4/16}, -- still torch
			{ -6/16, -6/16, -1/16, 6/16, -4/16, 1/16}, -- lock
		}
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = false,
	is_ground_content = false,
})
