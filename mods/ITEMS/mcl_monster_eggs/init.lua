-- Template function for registering monster egg blocks
local function register_block(subname, tiles, is_ground_content)
	if is_ground_content == nil then
		is_ground_content = false
	end
	minetest.register_node("mcl_monster_eggs:monster_egg_"..subname, {
		tiles = tiles,
		is_ground_content = is_ground_content,
		drop = "",
	})
end

-- Register all the monster egg blocks
register_block("stone", {"default_stone.png"}, true)
register_block("cobble", {"default_cobble.png"})
register_block("stonebrick", {"default_stone_brick.png"})
register_block("stonebrickcracked", {"mcl_core_stonebrick_cracked.png"})
register_block("stonebrickmossy", {"mcl_core_stonebrick_mossy.png"})
register_block("stonebrickcarved", {"mcl_core_stonebrick_carved.png"})


