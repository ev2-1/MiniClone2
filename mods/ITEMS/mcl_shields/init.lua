local minetest, math, vector = minetest, math, vector
local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

mcl_shields = {
	types = {
		mob = true,
		player = true,
		arrow = true,
		generic = true,
		explosion = true,
		dragon_breath = true,
	},
	enchantments = {"mending", "unbreaking"},
	players = {},
}

local interact_priv = minetest.registered_privileges.interact
interact_priv.give_to_singleplayer = false
interact_priv.give_to_admin = false

local overlay = mcl_enchanting.overlay
local hud = "mcl_shield_hud.png"

minetest.register_tool("mcl_shields:shield", {
	description = S("Shield"),
	_doc_items_longdesc = S("A shield is a tool used for protecting the player against attacks."),
	inventory_image = "mcl_shield.png",
	stack_max = 1,
	groups = {
		shield = 1,
		weapon = 1,
		enchantability = -1,
		no_wieldview = 1,
		offhand_item = 1,
	},
	sound = {breaks = "default_tool_breaks"},
	_repair_material = "group:wood",
	wield_scale = vector.new(2, 2, 2),
})

local function wielded_item(obj, i)
	local itemstack = obj:get_wielded_item()
	if i == 1 then
		itemstack = obj:get_inventory():get_stack("offhand", 1)
	end
	return itemstack:get_name()
end

function mcl_shields.wielding_shield(obj, i)
	return wielded_item(obj, i):find("mcl_shields:shield")
end

local function shield_is_enchanted(obj, i)
	return mcl_enchanting.is_enchanted(wielded_item(obj, i))
end

minetest.register_entity("mcl_shields:shield_entity", {
	initial_properties = {
		visual = "mesh",
		mesh = "mcl_shield.obj",
		physical = false,
		pointable = false,
		collide_with_objects = false,
		textures = {"mcl_shield_base_nopattern.png"},
		visual_size = vector.new(1, 1, 1),
	},
	_blocking = false,
	_shield_number = 2,
	_texture_copy = "",
	on_step = function(self, dtime, moveresult)
		local player = self.object:get_attach()
		if not player then
			self.object:remove()
			return
		end
		local shield_texture = "mcl_shield_base_nopattern.png"
		local i = self._shield_number
		local item = wielded_item(player, i)

		if item ~= "mcl_shields:shield" and item ~= "mcl_shields:shield_enchanted" then
			local itemstack = player:get_wielded_item()
			if i == 1 then
				itemstack = player:get_inventory():get_stack("offhand", 1)
			end
			local meta_texture = itemstack:get_meta():get_string("mcl_shields:shield_custom_pattern_texture")
			if meta_texture ~= "" then
				shield_texture = meta_texture
			else
				local color = minetest.registered_items[item]._shield_color
				if color then
					shield_texture = "mcl_shield_base_nopattern.png^(mcl_shield_pattern_base.png^[colorize:" .. color .. ")"
				end		
			end
		end

		if shield_is_enchanted(player, i) then
			shield_texture = shield_texture .. overlay
		end

		if self._texture_copy ~= shield_texture then
			self.object:set_properties({textures = {shield_texture}})
		end

		self._texture_copy = shield_texture
	end,
})

local function set_shield(player, block, i)
	if block then
		if i == 1 then
			modify_shield(player, vector.new(-9, 4, 0.5), vector.new(80, 100, 0), i) -- TODO
		else
			modify_shield(player, vector.new(-8, 4, -2.5), vector.new(80, 80, 0), i)
		end
	else
		if i == 1 then
			modify_shield(player, vector.new(-3, -5, 0), vector.new(0, 180, 0), i)
		else
			modify_shield(player, vector.new(3, -5, 0), vector.new(0, 0, 0), i)
		end
	end
	local shield = mcl_shields.players[player].shields[i]
	if not shield then return end

	local luaentity = shield:get_luaentity()
	if not luaentity then return end

	luaentity._blocking = block
end

local function set_interact(player, interact)
	local player_name = player:get_player_name()
	local privs = minetest.get_player_privs(player_name)
	if privs.interact == interact then
		return
	end
	local meta = player:get_meta()
	if meta:get_int("mcl_privs:interact_revoked") ~= 1 then
		privs.interact = interact
		minetest.set_player_privs(player_name, privs)
		meta:set_int("mcl_privs:interact_revoked",0)
	end
end

local shield_hud = {}

local function remove_shield_hud(player)
	if shield_hud[player] then
		player:hud_remove(shield_hud[player])
		shield_hud[player] = nil
		set_shield(player, false, 1)
		set_shield(player, false, 2)
	end

	local hf = player:hud_get_flags()
	if not hf.wielditem then
		player:hud_set_flags({wielditem = true})
	end

	playerphysics.remove_physics_factor(player, "speed", "shield_speed")
	set_interact(player, true)
end

local function add_shield_entity(player, i)
	local shield = minetest.add_entity(player:get_pos(), "mcl_shields:shield_entity")
	shield:get_luaentity()._shield_number = i
	mcl_shields.players[player].shields[i] = shield
	set_shield(player, false, i)
end

local function remove_shield_entity(player, i)
	local shields = mcl_shields.players[player].shields
	if shields[i] then
		shields[i]:remove()
		shields[i] = nil
	end
end

local function handle_blocking(player)
	local player_shield = mcl_shields.players[player]
	local rmb = player:get_player_control().RMB
	if not rmb then
		player_shield.blocking = 0
		return
	end

	local shield_in_offhand = mcl_shields.wielding_shield(player, 1)
	local shield_in_hand = mcl_shields.wielding_shield(player)
	local not_blocking = player_shield.blocking == 0

	local pos = player:get_pos()
	if shield_in_hand then
		if not_blocking then
			minetest.after(0.25, function()
				if (not_blocking or not shield_in_offhand) and shield_in_hand and rmb then
					player_shield.blocking = 2
					set_shield(player, true, 2)
				end
			end)
		elseif not shield_in_offhand then
			player_shield.blocking = 2
		end
	elseif shield_in_offhand then
		local offhand_can_block = (wielded_item(player) == "" or not mcl_util.get_pointed_thing(player, true)) 
		and (minetest.get_item_group(wielded_item(player), "bow") ~= 1 and minetest.get_item_group(wielded_item(player), "crossbow") ~= 1)

		if not offhand_can_block then
			return
		end
		if not_blocking then
			minetest.after(0.25, function()
				if (not_blocking or not shield_in_hand) and shield_in_offhand and rmb  and offhand_can_block then
					player_shield.blocking = 1
					set_shield(player, true, 1)
				end
			end)
		elseif not shield_in_hand then
			player_shield.blocking = 1
		end
	else
		player_shield.blocking = 0
	end
end

local function update_shield_entity(player, blocking, i)
	local shield = mcl_shields.players[player].shields[i]
	if mcl_shields.wielding_shield(player, i) then
		if not shield then
			add_shield_entity(player, i)
		else
			if blocking == i then
				if shield:get_luaentity() and not shield:get_luaentity()._blocking then
					set_shield(player, true, i)
				end
			else
				set_shield(player, false, i)
			end
		end
	elseif shield then
		remove_shield_entity(player, i)
	end
end

local function add_shield_hud(shieldstack, player, blocking)
	local texture = hud
	if mcl_enchanting.is_enchanted(shieldstack:get_name()) then
		texture = texture .. overlay
	end
	local offset = 100
	if blocking == 1 then
		texture = texture .. "^[transform4"
		offset = -100
	else
		player:hud_set_flags({wielditem = false})
	end
	shield_hud[player] = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.5, y = 0.5},
		scale = {x = -101, y = -101},
		offset = {x = offset, y = 0},
		text = texture,
		z_index = -200,
	})
	playerphysics.add_physics_factor(player, "speed", "shield_speed", 0.5)
	set_interact(player, nil)
end

local function update_shield_hud(player, blocking, shieldstack)
	local shieldhud = shield_hud[player]
	if not shieldhud then
		add_shield_hud(shieldstack, player, blocking)
		return
	end

	local wielditem = player:hud_get_flags().wielditem
	if blocking == 1 then
		if not wielditem then
			player:hud_change(shieldhud, "text", hud .. "^[transform4")
			player:hud_change(shieldhud, "offset", {x = -100, y = 0})
			player:hud_set_flags({wielditem = true})
		end
	elseif wielditem then
		player:hud_change(shieldhud, "text", hud)
		player:hud_change(shieldhud, "offset", {x = 100, y = 0})
		player:hud_set_flags({wielditem = false})
	end

	local image = player:hud_get(shieldhud).text
	local enchanted = hud .. overlay
	local enchanted1 = image == enchanted
	local enchanted2 = image == enchanted .. "^[transform4"
	if mcl_enchanting.is_enchanted(shieldstack:get_name()) then
		if not enchanted1 and not enchanted2 then
			if blocking == 1 then
				player:hud_change(shieldhud, "text", hud .. overlay .. "^[transform4")
			else
				player:hud_change(shieldhud, "text", hud .. overlay)
			end
		end
	elseif enchanted1 or enchanted2 then
		if blocking == 1 then
			player:hud_change(shieldhud, "text", hud .. "^[transform4")
		else
			player:hud_change(shieldhud, "text", hud)
		end
	end
end
