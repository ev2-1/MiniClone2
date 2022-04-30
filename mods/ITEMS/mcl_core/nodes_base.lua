-- Simple solid cubic nodes, most of them are the ground materials and simple building blocks

ice_drawtype = "glasslike"
ice_texture_alpha = minetest.features.use_texture_alpha_string_modes and "blend" or true

minetest.register_node("mcl_core:stone", {
	tiles = {"default_stone.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:stone_with_coal", {
	tiles = {"mcl_core_coal_ore.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:stone_with_iron", {
	tiles = {"mcl_core_iron_ore.png"},
	is_ground_content = true,
})


minetest.register_node("mcl_core:stone_with_gold", {
	tiles = {"mcl_core_gold_ore.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:stone_with_redstone", {
	tiles = {"mcl_core_redstone_ore.png"},
	is_ground_content = true,
	stack_max = 64,
})

-- Light the redstone ore up when it has been touched
minetest.register_node("mcl_core:stone_with_redstone_lit", {
	tiles = {"mcl_core_redstone_ore.png"},
	paramtype = "light",
	light_source = 9,
	is_ground_content = true,
})

minetest.register_node("mcl_core:stone_with_lapis", {
	tiles = {"mcl_core_lapis_ore.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:stone_with_emerald", {
	tiles = {"mcl_core_emerald_ore.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:stone_with_diamond", {
	tiles = {"mcl_core_diamond_ore.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:stonebrick", {
	tiles = {"default_stone_brick.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:stonebrickcarved", {
	tiles = {"mcl_core_stonebrick_carved.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:stonebrickcracked", {
	tiles = {"mcl_core_stonebrick_cracked.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:stonebrickmossy", {
	tiles = {"mcl_core_stonebrick_mossy.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:stone_smooth", {
	tiles = {"mcl_stairs_stone_slab_top.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:granite", {
	tiles = {"mcl_core_granite.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:granite_smooth", {
	tiles = {"mcl_core_granite_smooth.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:andesite", {
	tiles = {"mcl_core_andesite.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:andesite_smooth", {
	tiles = {"mcl_core_andesite_smooth.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:diorite", {
	tiles = {"mcl_core_diorite.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:diorite_smooth", {
	tiles = {"mcl_core_diorite_smooth.png"},
	is_ground_content = false,
})

-- Grass Block
minetest.register_node("mcl_core:dirt_with_grass", {
	paramtype2 = "color",
	tiles = {"mcl_core_grass_block_top.png", { name="default_dirt.png", color="white" }},
	overlay_tiles = {"mcl_core_grass_block_top.png", "", {name="mcl_core_grass_block_side_overlay.png", tileable_vertical=false}},
	palette = "mcl_core_palette_grass.png",
	palette_index = 0,
	color = "#8EB971",
	is_ground_content = true,
})

minetest.register_node("mcl_core:grass_path", {
	tiles = {"mcl_core_grass_path_top.png", "default_dirt.png", "mcl_core_grass_path_side.png"},
	is_ground_content = true,
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			-- 15/16 of the normal height
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
})

-- TODO: Add particles
minetest.register_node("mcl_core:mycelium", {
	tiles = {"mcl_core_mycelium_top.png", "default_dirt.png", {name="mcl_core_mycelium_side.png", tileable_vertical=false}},
	is_ground_content = true,
})

minetest.register_node("mcl_core:podzol", {
	tiles = {"mcl_core_dirt_podzol_top.png", "default_dirt.png", {name="mcl_core_dirt_podzol_side.png", tileable_vertical=false}},
	is_ground_content = true,
})

minetest.register_node("mcl_core:dirt", {
	tiles = {"default_dirt.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:coarse_dirt", {
	tiles = {"mcl_core_coarse_dirt.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:gravel", {
	tiles = {"default_gravel.png"},
	is_ground_content = true,
})

-- sandstone --
minetest.register_node("mcl_core:sand", {
	tiles = {"default_sand.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:sandstone", {
	tiles = {"mcl_core_sandstone_top.png", "mcl_core_sandstone_bottom.png", "mcl_core_sandstone_normal.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:sandstonesmooth", {
	tiles = {"mcl_core_sandstone_top.png", "mcl_core_sandstone_bottom.png", "mcl_core_sandstone_smooth.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:sandstonecarved", {
	tiles = {"mcl_core_sandstone_top.png", "mcl_core_sandstone_bottom.png", "mcl_core_sandstone_carved.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:sandstonesmooth2", {
	tiles = {"mcl_core_sandstone_top.png"},
	is_ground_content = false,
})

-- red sandstone --
minetest.register_node("mcl_core:redsand", {
	tiles = {"mcl_core_red_sand.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:redsandstone", {
	tiles = {"mcl_core_red_sandstone_top.png", "mcl_core_red_sandstone_bottom.png", "mcl_core_red_sandstone_normal.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:redsandstonesmooth", {
	tiles = {"mcl_core_red_sandstone_top.png", "mcl_core_red_sandstone_bottom.png", "mcl_core_red_sandstone_smooth.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:redsandstonecarved", {
	tiles = {"mcl_core_red_sandstone_top.png", "mcl_core_red_sandstone_bottom.png", "mcl_core_red_sandstone_carved.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:redsandstonesmooth2", {
	tiles = {"mcl_core_red_sandstone_top.png"},
	is_ground_content = false,
})

---

minetest.register_node("mcl_core:clay", {
	tiles = {"default_clay.png"},
	is_ground_content = true,
})

minetest.register_node("mcl_core:brick_block", {
	tiles = {"default_brick.png"},
	is_ground_content = false,
})


minetest.register_node("mcl_core:bedrock", {
	tiles = {"mcl_core_bedrock.png"},
	stack_max = 64,
})

minetest.register_node("mcl_core:cobble", {
	tiles = {"default_cobble.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:mossycobble", {
	tiles = {"default_mossycobble.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:coalblock", {
	tiles = {"default_coal_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:ironblock", {
	tiles = {"default_steel_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:goldblock", {
	tiles = {"default_gold_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:diamondblock", {
	tiles = {"default_diamond_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:lapisblock", {
	tiles = {"mcl_core_lapis_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:emeraldblock", {
	tiles = {"mcl_core_emerald_block.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:obsidian", {
	tiles = {"default_obsidian.png"},
	is_ground_content = false,
})

minetest.register_node("mcl_core:ice", {
	drawtype = ice_drawtype,
	tiles = {"default_ice.png"},
	is_ground_content = true,
	paramtype = "light",
	use_texture_alpha = ice_texture_alpha,
	stack_max = 64,
	groups = {handy=1,pickaxey=1, slippery=3, building_block=1, ice=1},
	drop = "",
})

minetest.register_node("mcl_core:packed_ice", {
	tiles = {"mcl_core_ice_packed.png"},
	is_ground_content = true,
})

-- Frosted Ice (4 nodes)
for i=0,3 do
	local ice = {}
	minetest.register_node("mcl_core:frosted_ice_"..i, {
		drawtype = ice_drawtype,
		tiles = {"mcl_core_frosted_ice_"..i..".png"},
		is_ground_content = false,
		paramtype = "light",
	})
end

for i=1,8 do
	local id, desc, walkable, drawtype, node_box
	if i == 1 then
		id = "mcl_core:snow"
		walkable = false
	else
		id = "mcl_core:snow_"..i
		walkable = true
	end
	if i ~= 8 then
		drawtype = "nodebox"
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, -0.5 + (2*i)/16, 0.5 },
		}
	end

	minetest.register_node(id, {
		tiles = {"default_snow.png"},
		wield_image = "default_snow.png",
		wield_scale = { x=1, y=1, z=i },
		is_ground_content = true,
		paramtype = "light",
		sunlight_propagates = true,
		buildable_to = true,
		node_placement_prediction = "", -- to prevent client flickering when stacking snow
		drawtype = drawtype,
		walkable = walkable,
		node_box = node_box,
	})
end

minetest.register_node("mcl_core:snowblock", {
	tiles = {"default_snow.png"},
	is_ground_content = true,
})
