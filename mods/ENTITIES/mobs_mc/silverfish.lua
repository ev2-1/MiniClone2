--###################
--################### SILVERFISH
--###################

local S = minetest.get_translator("mobs_mc")

mobs:register_mob("mobs_mc:silverfish", {
	description = S("Silverfish"),
	type = "monster",
	spawn_class = "hostile",
	passive = false,
	group_attack = true,
	reach = 1,
	hp_min = 8,
	hp_max = 8,
	xp_min = 5,
	xp_max = 5,
	armor = {fleshy = 100, arthropod = 100},
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.44, 0.4},
	visual = "mesh",
	mesh = "mobs_mc_silverfish.b3d",
	textures = {
		{"mobs_mc_silverfish.png"},
	},
	pathfinding = 1,
	visual_size = {x=3, y=3},
	sounds = {
		random = "mobs_mc_silverfish_idle",
		death = "mobs_mc_silverfish_death",
		damage = "mobs_mc_silverfish_hurt",
		distance = 16,
	},
	makes_footstep_sound = false,
	walk_velocity = 0.6,
	run_velocity = 2,
	jump = true,
	fear_height = 4,
	replace_what = mobs_mc.replace.silverfish,
	replace_rate = 2,
	animation = {
		speed_normal = 25,		speed_run = 50,
		stand_start = 0,		stand_end = 20,
		walk_start = 0,		walk_end = 20,
		run_start = 0,		run_end = 20,
	},
	view_range = 16,
	attack_type = "dogfight",
	damage = 1,
	reach = 1,
})

mobs:register_egg("mobs_mc:silverfish", S("Silverfish"), "mobs_mc_spawn_icon_silverfish.png", 0)

-- Monster egg blocks (Minetest Game)
if minetest.get_modpath("default") and mobs_mc.create_monster_egg_nodes then
	local spawn_silverfish = function(pos, oldnode, oldmetadata, digger)
		if not minetest.is_creative_enabled(digger:get_player_name()) then
			minetest.add_entity(pos, "mobs_mc:silverfish")
		end
	end
	minetest.register_node("mobs_mc:monster_egg_stone", {
		description = "Stone Monster Egg",
		tiles = {"default_stone.png"},
		groups = {oddly_breakable_by_hand = 2, spawns_silverfish = 1},
		drop = '',
		is_ground_content = true,
		sounds = default.node_sound_stone_defaults(),
		after_dig_node = spawn_silverfish,
	})

	minetest.register_node("mobs_mc:monster_egg_cobble", {
		description = "Cobblestone Monster Egg",
		tiles = {"default_cobble.png"},
		is_ground_content = false,
		groups = {oddly_breakable_by_hand = 2, spawns_silverfish = 1},
		drop = '',
		sounds = default.node_sound_stone_defaults(),
		after_dig_node = spawn_silverfish,
	})

	minetest.register_node("mobs_mc:monster_egg_mossycobble", {
		description = "Mossy Cobblestone Monster Egg",
		tiles = {"default_mossycobble.png"},
		is_ground_content = false,
		groups = {oddly_breakable_by_hand = 2, spawns_silverfish = 1},
		drop = '',
		sounds = default.node_sound_stone_defaults(),
		after_dig_node = spawn_silverfish,
	})

	minetest.register_node("mobs_mc:monster_egg_stonebrick", {
		description = "Stone Brick Monster Egg",
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {"default_stone_brick.png"},
		is_ground_content = false,
		groups = {oddly_breakable_by_hand = 2, spawns_silverfish = 1},
		drop = '',
		sounds = default.node_sound_stone_defaults(),
		after_dig_node = spawn_silverfish,
	})

	minetest.register_node("mobs_mc:monster_egg_stone_block", {
		description = "Stone Block Monster Egg",
		tiles = {"default_stone_block.png"},
		is_ground_content = false,
		groups = {oddly_breakable_by_hand = 2, spawns_silverfish = 1},
		drop = '',
		sounds = default.node_sound_stone_defaults(),
		after_dig_node = spawn_silverfish,
	})

	-- Randomly spawn stone monster eggs in the world
	local mg_name = minetest.get_mapgen_setting("mg_name")
	local scarcity
	if mg_name == "v6" then
		scarcity = 28 * 28 * 28
	else
		scarcity = 22 * 22 * 22
	end
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "mobs_mc:monster_egg_stone",
		wherein        = "default:stone",
		clust_scarcity = scarcity,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = 31000,
		biomes         = { "grassland" },
	})

end
