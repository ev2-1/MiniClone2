
---- Trapdoor ----

function mcl_doors:register_trapdoor(name, def)

	-- Closed trapdoor

	local tile_front = def.tile_front
	local tile_side = def.tile_side
	if not tile_side then
		tile_side = tile_front
	end
	local tiles_closed = {
		tile_front,
		tile_front .. "^[transformFY",
		tile_side, tile_side,
		tile_side, tile_side,
	}

	minetest.register_node(name, {
		drawtype = "nodebox",
		tiles = tiles_closed,
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		is_ground_content = false,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		node_box = {
			type = "fixed",
			fixed = {
			{-8/16, -8/16, -8/16, 8/16, -5/16, 8/16},},
		},
	})

	-- Open trapdoor

	local tiles_open = {
		tile_side,
		tile_side .. "^[transformR180",
		tile_side .. "^[transformR270",
		tile_side .. "^[transformR90",
		tile_front .. "^[transform46",
		tile_front .. "^[transformFY",
	}

	minetest.register_node(name.."_open", {
		drawtype = "nodebox",
		tiles = tiles_open,
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		is_ground_content = false,
		paramtype = "light",
		paramtype2 = "facedir",
		climbable = true,
		sunlight_propagates = true,
		pointable = true,
		groups = groups_open,
		sounds = def.sounds,
		drop = name,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 5/16, 0.5, 0.5, 0.5}
		},
	})
end
