-- Chest Entity
local animate_chests = (minetest.settings:get_bool("animated_chests") ~= false)
local entity_animations = {
	shulker = {
		speed = 50,
		open = {x = 45, y = 95},
		close = {x = 95, y = 145},
	},
	chest = {
		speed = 25,
		open = {x = 0, y = 7},
		close = {x = 13, y = 20},
	}
}

minetest.register_entity("mcl_chests:chest", {
	initial_properties = {
		visual = "mesh",
		visual_size = {x = 3, y = 3},
		pointable = false,
		physical = false,
		static_save = false,
	},
})

local function get_entity_pos(pos, dir, double)
	pos = vector.new(pos)
	pos.y = pos.y - 0.49
	if double then
		local add, mul, vec, cross = vector.add, vector.multiply, vector.new, vector.cross
		pos = add(pos, mul(cross(dir, vec(0, 1, 0)), -0.5))
	end
	return pos
end

local function find_entity(pos)
	for _, obj in pairs(minetest.get_objects_inside_radius(pos, 0)) do
		local luaentity = obj:get_luaentity()
		if luaentity and luaentity.name == "mcl_chests:chest" then
			return luaentity
		end
	end
end

local function get_entity_info(pos, param2, double, dir, entity_pos)
	dir = dir or minetest.facedir_to_dir(param2)
	return dir, get_entity_pos(pos, dir, double)
end

local function create_entity(pos, node_name, textures, param2, double, sound_prefix, mesh_prefix, animation_type, dir, entity_pos)
	dir, entity_pos = get_entity_info(pos, param2, double, dir, entity_pos)
	local obj = minetest.add_entity(entity_pos, "mcl_chests:chest")
	local luaentity = obj:get_luaentity()
	luaentity:initialize(pos, node_name, textures, dir, double, sound_prefix, mesh_prefix, animation_type)
	return luaentity
end

local function find_or_create_entity(pos, node_name, textures, param2, double, sound_prefix, mesh_prefix, animation_type, dir, entity_pos)
	dir, entity_pos = get_entity_info(pos, param2, double, dir, entity_pos)
	return find_entity(entity_pos) or create_entity(pos, node_name, textures, param2, double, sound_prefix, mesh_prefix, animation_type, dir, entity_pos)
end

-- This is a helper function to register both chests and trapped chests. Trapped chests will make use of the additional parameters
local function register_chest(basename, tiles_table)
	local small_name = "mcl_chests:"..basename.."_small"
	local small_textures = tiles_table.small
	local left_name = "mcl_chests:"..basename.."_left"
	local left_textures = tiles_table.double

	minetest.register_node("mcl_chests:"..basename, {
		description = desc,
		drawtype = "mesh",
		mesh = "mcl_chests_chest.obj",
		tiles = small_textures,
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
		paramtype = "light",
		paramtype2 = "facedir",
	})

	minetest.register_node(small_name, {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.4375, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
		},
		tiles = {"mcl_chests_blank.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
	})

	minetest.register_node(left_name, {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.4375, -0.5, -0.4375, 0.5, 0.375, 0.4375},
		},
		tiles = {"mcl_chests_blank.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = drop,
		is_ground_content = false,
	})

	minetest.register_node("mcl_chests:"..basename.."_right", {
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
		},
		tiles = {"mcl_chests_blank.png"},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		is_ground_content = false,
	})
end

register_chest("chest",
	{
		small = {"mcl_chests_normal.png"},
		double = {"mcl_chests_normal_double.png"},
		inv = {"default_chest_top.png", "mcl_chests_chest_bottom.png",
		"mcl_chests_chest_right.png", "mcl_chests_chest_left.png",
		"mcl_chests_chest_back.png", "default_chest_front.png"},
		--[[left = {"default_chest_top_big.png", "default_chest_top_big.png",
		"mcl_chests_chest_right.png", "mcl_chests_chest_left.png",
		"default_chest_side_big.png^[transformFX", "default_chest_front_big.png"},
		right = {"default_chest_top_big.png^[transformFX", "default_chest_top_big.png^[transformFX",
		"mcl_chests_chest_right.png", "mcl_chests_chest_left.png",
		"default_chest_side_big.png", "default_chest_front_big.png^[transformFX"},]]--
	}
)

local traptiles = {
	small = {"mcl_chests_trapped.png"},
	double = {"mcl_chests_trapped_double.png"},
	inv = {"mcl_chests_chest_trapped_top.png", "mcl_chests_chest_trapped_bottom.png",
	"mcl_chests_chest_trapped_right.png", "mcl_chests_chest_trapped_left.png",
	"mcl_chests_chest_trapped_back.png", "mcl_chests_chest_trapped_front.png"},
	--[[left = {"mcl_chests_chest_trapped_top_big.png", "mcl_chests_chest_trapped_top_big.png",
	"mcl_chests_chest_trapped_right.png", "mcl_chests_chest_trapped_left.png",
	"mcl_chests_chest_trapped_side_big.png^[transformFX", "mcl_chests_chest_trapped_front_big.png"},
	right = {"mcl_chests_chest_trapped_top_big.png^[transformFX", "mcl_chests_chest_trapped_top_big.png^[transformFX",
	"mcl_chests_chest_trapped_right.png", "mcl_chests_chest_trapped_left.png",
	"mcl_chests_chest_trapped_side_big.png", "mcl_chests_chest_trapped_front_big.png^[transformFX"},]]--
}

register_chest("trapped_chest", traptiles)
register_chest("trapped_chest_on", traptiles)

minetest.register_node("mcl_chests:ender_chest", {
	drawtype = "mesh",
	mesh = "mcl_chests_chest.obj",
	tiles = {"mcl_chests_ender.png"},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	paramtype = "light",
	paramtype2 = "facedir",
})

minetest.register_node("mcl_chests:ender_chest_small", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.4375, -0.5, -0.4375, 0.5, 0.375, 0.4375},
	},
	_chest_entity_textures = {"mcl_chests_ender.png"},
	_chest_entity_sound = "mcl_chests_enderchest",
	_chest_entity_mesh = "mcl_chests_chest",
	_chest_entity_animation_type = "chest",
	tiles = {"mcl_chests_blank.png"},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
	--[[{"mcl_chests_ender_chest_top.png", "mcl_chests_ender_chest_bottom.png",
		"mcl_chests_ender_chest_right.png", "mcl_chests_ender_chest_left.png",
		"mcl_chests_ender_chest_back.png", "mcl_chests_ender_chest_front.png"},]]--
	-- Note: The “container” group is missing here because the ender chest does not
	-- have an inventory on its own
	groups = {pickaxey=1, deco_block=1, material_stone=1, chest_entity=1, not_in_creative_inventory=1},
	is_ground_content = false,
	paramtype = "light",
	light_source = 7,
	paramtype2 = "facedir",
	sounds = mcl_sounds.node_sound_stone_defaults(),
})

minetest.register_allow_player_inventory_action(function(player, action, inv, info)
	if inv:get_location().type == "player" and (
		   action == "move" and (info.from_list == "enderchest" or info.to_list == "enderchest")
		or action == "put"  and  info.listname  == "enderchest"
		or action == "take" and  info.listname  == "enderchest"
	) then
		local def = player:get_wielded_item():get_definition()

		if not minetest.find_node_near(player:get_pos(), def and def.range or ItemStack():get_definition().range, "mcl_chests:ender_chest_small", true) then
			return 0
		end
	end
end)

-- Shulker boxes
local boxtypes = {
	white = "",
	grey = "",
	orange = "",
	cyan = "",
	magenta = "",
	violet = "",
	lightblue = "",
	blue = "",
	yellow = "",
	brown = "",
	green = "",
	dark_green = "",
	pink = "",
	red = "",
	dark_grey = "",
	black = "",
}

local shulker_mob_textures = {
	white = "mobs_mc_shulker_white.png",
	grey = "mobs_mc_shulker_silver.png",
	orange = "mobs_mc_shulker_orange.png",
	cyan = "mobs_mc_shulker_cyan.png",
	magenta = "mobs_mc_shulker_magenta.png",
	violet = "mobs_mc_shulker_purple.png",
	lightblue = "mobs_mc_shulker_light_blue.png",
	blue = "mobs_mc_shulker_blue.png",
	yellow = "mobs_mc_shulker_yellow.png",
	brown = "mobs_mc_shulker_brown.png",
	green = "mobs_mc_shulker_lime.png",
	dark_green = "mobs_mc_shulker_green.png",
	pink = "mobs_mc_shulker_pink.png",
	red = "mobs_mc_shulker_red.png",
	dark_grey = "mobs_mc_shulker_gray.png",
	black = "mobs_mc_shulker_black.png",
}
local canonical_shulker_color = "violet"

local function set_shulkerbox_meta(nmeta, imeta)
	local name = imeta:get_string("name")
end

for color, desc in pairs(boxtypes) do
	local mob_texture = shulker_mob_textures[color]
	local is_canonical = color == canonical_shulker_color
	local longdesc, usagehelp, create_entry, entry_name
	if mod_doc then
		if not is_canonical then
			create_entry = false
		end
	end

	local small_name = "mcl_chests:"..color.."_shulker_box_small"

	minetest.register_node("mcl_chests:"..color.."_shulker_box", {
		tiles = {mob_texture},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
		drawtype = "mesh",
		mesh = "mcl_chests_shulker.obj",
		is_ground_content = false,
		paramtype = "light",
		paramtype2 = "facedir",
	})

	minetest.register_node(small_name, {
		description = desc,
		drawtype = "nodebox",
		tiles = {"mcl_chests_blank.png"},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		is_ground_content = false,
		sounds = mcl_sounds.node_sound_stone_defaults(),
		stack_max = 1,
		drop = "",
		paramtype = "light",
		paramtype2 = "facedir",
	})
end
