local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

local math = math
local vector = vector

mcl_enchanting = {
	book_offset = vector.new(0, 0.75, 0),
	book_animations = {["close"] = 1, ["opening"] = 2, ["open"] = 3, ["closing"] = 4},
	book_animation_steps = {0, 640, 680, 700, 740},
	book_animation_loop = {["open"] = true, ["close"] = true},
	book_animation_speed = 40,
	roman_numerals = dofile(modpath .. "/roman_numerals.lua"), 			-- https://exercism.io/tracks/lua/exercises/roman-numerals/solutions/73c2fb7521e347209312d115f872fa49
	enchantments = {},
	overlay = "^[colorize:purple:50",
	--overlay = "^[invert:rgb^[multiply:#4df44d:50^[invert:rgb",
	enchanting_lists = {"enchanting", "enchanting_item", "enchanting_lapis"},
	bookshelf_positions = {
		{x = -2, y = 0, z = -2}, {x = -2, y = 1, z = -2},
		{x = -1, y = 0, z = -2}, {x = -1, y = 1, z = -2},
		{x =  0, y = 0, z = -2}, {x =  0, y = 1, z = -2},
		{x =  1, y = 0, z = -2}, {x =  1, y = 1, z = -2},
		{x =  2, y = 0, z = -2}, {x =  2, y = 1, z = -2},
		{x = -2, y = 0, z =  2}, {x = -2, y = 1, z =  2},
		{x = -1, y = 0, z =  2}, {x = -1, y = 1, z =  2},
		{x =  0, y = 0, z =  2}, {x =  0, y = 1, z =  2},
		{x =  1, y = 0, z =  2}, {x =  1, y = 1, z =  2},
		{x =  2, y = 0, z =  2}, {x =  2, y = 1, z =  2},
		-- {x = -2, y = 0, z = -2}, {x = -2, y = 1, z = -2},
		{x = -2, y = 0, z = -1}, {x = -2, y = 1, z = -1},
		{x = -2, y = 0, z =  0}, {x = -2, y = 1, z =  0},
		{x = -2, y = 0, z =  1}, {x = -2, y = 1, z =  1},
		-- {x = -2, y = 0, z =  2}, {x = -2, y = 1, z =  2},
		-- {x =  2, y = 0, z = -2}, {x =  2, y = 1, z = -2},
		{x =  2, y = 0, z = -1}, {x =  2, y = 1, z = -1},
		{x =  2, y = 0, z =  0}, {x =  2, y = 1, z =  0},
		{x =  2, y = 0, z =  1}, {x =  2, y = 1, z =  1},
		-- {x =  2, y = 0, z =  2}, {x =  2, y = 1, z =  2},
	},
	air_positions = {
		{x = -1, y = 0, z = -1}, {x = -1, y = 1, z = -1},
		{x = -1, y = 0, z = -1}, {x = -1, y = 1, z = -1},
		{x =  0, y = 0, z = -1}, {x =  0, y = 1, z = -1},
		{x =  1, y = 0, z = -1}, {x =  1, y = 1, z = -1},
		{x =  1, y = 0, z = -1}, {x =  1, y = 1, z = -1},
		{x = -1, y = 0, z =  1}, {x = -1, y = 1, z =  1},
		{x = -1, y = 0, z =  1}, {x = -1, y = 1, z =  1},
		{x =  0, y = 0, z =  1}, {x =  0, y = 1, z =  1},
		{x =  1, y = 0, z =  1}, {x =  1, y = 1, z =  1},
		{x =  1, y = 0, z =  1}, {x =  1, y = 1, z =  1},
		-- {x = -1, y = 0, z = -1}, {x = -1, y = 1, z = -1},
		{x = -1, y = 0, z = -1}, {x = -1, y = 1, z = -1},
		{x = -1, y = 0, z =  0}, {x = -1, y = 1, z =  0},
		{x = -1, y = 0, z =  1}, {x = -1, y = 1, z =  1},
		-- {x = -1, y = 0, z =  1}, {x = -1, y = 1, z =  1},
		-- {x =  1, y = 0, z = -1}, {x =  1, y = 1, z = -1},
		{x =  1, y = 0, z = -1}, {x =  1, y = 1, z = -1},
		{x =  1, y = 0, z =  0}, {x =  1, y = 1, z =  0},
		{x =  1, y = 0, z =  1}, {x =  1, y = 1, z =  1},
		-- {x =  1, y = 0, z =  1}, {x =  1, y = 1, z =  1},
	},
}

dofile(modpath .. "/engine.lua")
dofile(modpath .. "/groupcaps.lua")
--dofile(modpath .. "/enchantments.lua")

minetest.register_alias("mcl_books:book_enchanted", "mcl_enchanting:book_enchanted")

local function spawn_book_entity(pos, respawn)
	if respawn then
		-- Check if we already have a book
		local objs = minetest.get_objects_inside_radius(pos, 1)
		for o=1, #objs do
			local obj = objs[o]
			local lua = obj:get_luaentity()
			if lua and lua.name == "mcl_enchanting:book" then
				if lua._table_pos and vector.equals(pos, lua._table_pos) then
					return
				end
			end
		end
	end
	local obj = minetest.add_entity(vector.add(pos, mcl_enchanting.book_offset), "mcl_enchanting:book")
	if obj then
		local lua = obj:get_luaentity()
		if lua then
			lua._table_pos = table.copy(pos)
		end
	end
end

minetest.register_entity("mcl_enchanting:book", {
	initial_properties = {
		visual = "mesh",
		mesh = "mcl_enchanting_book.b3d",
		visual_size = {x = 12.5, y = 12.5},
		collisionbox = {0, 0, 0},
		pointable = false,
		physical = false,
		textures = {"mcl_enchanting_book_entity.png", "mcl_enchanting_book_entity.png", "mcl_enchanting_book_entity.png", "mcl_enchanting_book_entity.png", "mcl_enchanting_book_entity.png"},
		static_save = false,
	},
	_player_near = false,
	_table_pos = nil,
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal = 1})
		mcl_enchanting.set_book_animation(self, "close")
	end,
	on_step = function(self, dtime)
		local old_player_near = self._player_near
		local player_near = false
		local player
		for _, obj in pairs(minetest.get_objects_inside_radius(vector.subtract(self.object:get_pos(), mcl_enchanting.book_offset), 2.5)) do
			if obj:is_player() then
				player_near = true
				player = obj
			end
		end
		if player_near and not old_player_near then
			mcl_enchanting.set_book_animation(self, "opening")
			mcl_enchanting.schedule_book_animation(self, "open")
		elseif old_player_near and not player_near then
			mcl_enchanting.set_book_animation(self, "closing")
			mcl_enchanting.schedule_book_animation(self, "close")
		end
		if player then
			mcl_enchanting.look_at(self, player:get_pos())
		end
		self._player_near = player_near
		mcl_enchanting.check_animation_schedule(self, dtime)
	end,
})

minetest.register_node("mcl_enchanting:table", {
	drawtype = "nodebox",
	tiles = {"mcl_enchanting_table_top.png",  "mcl_enchanting_table_bottom.png", "mcl_enchanting_table_side.png", "mcl_enchanting_table_side.png", "mcl_enchanting_table_side.png", "mcl_enchanting_table_side.png"},
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
	},
	groups = {pickaxey = 2, deco_block = 1},
	on_rotate = rotate,
	on_construct = function(pos)
		spawn_book_entity(pos)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local dname = (digger and digger:get_player_name()) or ""
		if minetest.is_creative_enabled(dname) then
			return
		end
		local itemstack = ItemStack("mcl_enchanting:table")
		local meta = minetest.get_meta(pos)
		local itemmeta = itemstack:get_meta()
		itemmeta:set_string("name", meta:get_string("name"))
		itemmeta:set_string("description", meta:get_string("description"))
		minetest.add_item(pos, itemstack)
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local itemmeta = itemstack:get_meta()
		meta:set_string("name", itemmeta:get_string("name"))
		meta:set_string("description", itemmeta:get_string("description"))
	end,
	after_destruct = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 1)
		for o=1, #objs do
			local obj = objs[o]
			local lua = obj:get_luaentity()
			if lua and lua.name == "mcl_enchanting:book" then
				if lua._table_pos and vector.equals(pos, lua._table_pos) then
					obj:remove()
				end
			end
		end
	end,
	drop = "",
	_mcl_blast_resistance = 1200,
	_mcl_hardness = 5,
})

minetest.register_craft({
	output = "mcl_enchanting:table",
	recipe = {
		{"", "mcl_books:book", ""},
		{"mcl_core:diamond", "mcl_core:obsidian", "mcl_core:diamond"},
		{"mcl_core:obsidian", "mcl_core:obsidian", "mcl_core:obsidian"}
	}
})

minetest.register_abm({
	label = "Enchanting table bookshelf particles",
	interval = 1,
	chance = 1,
	nodenames = "mcl_enchanting:table",
	action = function(pos)
		local playernames = {}
		for _, obj in pairs(minetest.get_objects_inside_radius(pos, 15)) do
			if obj:is_player() then
				table.insert(playernames, obj:get_player_name())
			end
		end
		if #playernames < 1 then
			return
		end
		local absolute, relative = mcl_enchanting.get_bookshelves(pos)
		for i, ap in ipairs(absolute) do
			if math.random(5) == 1 then
				local rp = relative[i]
				local t = math.random()+1 --time
				local d = {x = rp.x, y=rp.y-0.7, z=rp.z} --distance
				local v = {x = -math.random()*d.x, y = math.random(), z = -math.random()*d.z} --velocity
				local a = {x = 2*(-v.x*t - d.x)/t/t, y = 2*(-v.y*t - d.y)/t/t, z = 2*(-v.z*t - d.z)/t/t} --acceleration
				local s = math.random()+0.9 --size
				t = t - 0.1 --slightly decrease time to avoid texture overlappings
				local tx = "mcl_enchanting_glyph_" .. math.random(18) .. ".png"
				for _, name in pairs(playernames) do
					minetest.add_particle({
						pos = ap,
						velocity = v,
						acceleration = a,
						expirationtime = t,
						size = s,
						texture = tx,
						collisiondetection = false,
						playername = name
					})
				end
			end
		end
	end
})

minetest.register_lbm({
	label = "(Re-)spawn book entity above enchanting table",
	name = "mcl_enchanting:spawn_book_entity",
	nodenames = {"mcl_enchanting:table"},
	run_at_every_load = true,
	action = function(pos)
		spawn_book_entity(pos, true)
	end,
})


minetest.register_on_mods_loaded(mcl_enchanting.initialize)
minetest.register_on_joinplayer(mcl_enchanting.initialize_player)
minetest.register_on_player_receive_fields(mcl_enchanting.handle_formspec_fields)
minetest.register_allow_player_inventory_action(mcl_enchanting.allow_inventory_action)
minetest.register_on_player_inventory_action(mcl_enchanting.on_inventory_action)
