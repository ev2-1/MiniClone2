--[[ This mod registers 3 nodes:
- One node for the horizontal-facing dispensers (mcl_dispensers:dispenser)
- One node for the upwards-facing dispensers (mcl_dispenser:dispenser_up)
- One node for the downwards-facing dispensers (mcl_dispenser:dispenser_down)

3 node definitions are needed because of the way the textures are defined.
All node definitions share a lot of code, so this is the reason why there
are so many weird tables below.
]]
local S = minetest.get_translator(minetest.get_current_modname())

local function orientate_dispenser(pos, placer)
	-- Not placed by player
	if not placer then return end

	-- Pitch in degrees
	local pitch = placer:get_look_vertical() * (180 / math.pi)

	local node = minetest.get_node(pos)
	if pitch > 55 then
		minetest.swap_node(pos, {name="mcl_dispensers:dispenser_up", param2 = node.param2})
	elseif pitch < -55 then
		minetest.swap_node(pos, {name="mcl_dispensers:dispenser_down", param2 = node.param2})
	end
end

-- Shared core definition table
local dispenserdef = {
	is_ground_content = false,
	sounds = mcl_sounds.node_sound_stone_defaults(),
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return count
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta:to_table()
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2)
	end,
	mesecons = {
		effector = {
			-- Dispense random item when triggered
			action_on = function(pos, node)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local droppos, dropdir
				if node.name == "mcl_dispensers:dispenser" then
					dropdir = vector.multiply(minetest.facedir_to_dir(node.param2), -1)
					droppos = vector.add(pos, dropdir)
				elseif node.name == "mcl_dispensers:dispenser_up" then
					dropdir = {x=0, y=1, z=0}
					droppos  = {x=pos.x, y=pos.y+1, z=pos.z}
				elseif node.name == "mcl_dispensers:dispenser_down" then
					dropdir = {x=0, y=-1, z=0}
					droppos  = {x=pos.x, y=pos.y-1, z=pos.z}
				end
				local dropnode = minetest.get_node(droppos)
				local dropnodedef = minetest.registered_nodes[dropnode.name]
				local stacks = {}
				for i=1,inv:get_size("main") do
					local stack = inv:get_stack("main", i)
					if not stack:is_empty() then
						table.insert(stacks, {stack = stack, stackpos = i})
					end
				end
				if #stacks >= 1 then
					local r = math.random(1, #stacks)
					local stack = stacks[r].stack
					local dropitem = ItemStack(stack)
					dropitem:set_count(1)
					local stack_id = stacks[r].stackpos
					local stackdef = stack:get_definition()

					if not stackdef then
						return
					end
					
					local iname = stack:get_name()
					local igroups = stackdef.groups

					--[===[ Dispense item ]===]

					-- Hardcoded dispensions --

					-- Armor, mob heads and pumpkins
					if igroups.armor then
						local droppos_below = {x = droppos.x, y = droppos.y - 1, z = droppos.z}

						for _, objs in ipairs({minetest.get_objects_inside_radius(droppos, 1), minetest.get_objects_inside_radius(droppos_below, 1)}) do
							for _, obj in ipairs(objs) do
								stack = mcl_armor.equip(stack, obj)
								if stack:is_empty() then
									break
								end
							end
							if stack:is_empty() then
								break
							end
						end

							-- Place head or pumpkin as node, if equipping it as armor has failed
						if not stack:is_empty() then
							if igroups.head or iname == "mcl_farming:pumpkin_face" then
								if dropnodedef.buildable_to then
									minetest.set_node(droppos, {name = iname, param2 = node.param2})
									stack:take_item()
								end
							end
						end

						inv:set_stack("main", stack_id, stack)

					-- Use shears on sheeps
					elseif igroups.shears then
						for _, obj in pairs(minetest.get_objects_inside_radius(droppos, 1)) do
							local entity = obj:get_luaentity()
							if entity and not entity.child and not entity.gotten then
								local entname = entity.name
								local pos = obj:get_pos()
								local used, texture = false
								if entname == "mobs_mc:sheep" then
									minetest.add_item(pos, entity.drops[2].name .. " " .. math.random(1, 3))
									if not entity.color then
										entity.color = "unicolor_white"
									end
									entity.base_texture = { "blank.png", "mobs_mc_sheep.png" }
									texture = entity.base_texture
									entity.drops = {
										{ name = mobs_mc.items.mutton_raw, chance = 1, min = 1, max = 2 },
									}
									used = true
								elseif entname == "mobs_mc:snowman" then
									texture = {
										"mobs_mc_snowman.png",
										"blank.png", "blank.png",
										"blank.png", "blank.png",
										"blank.png", "blank.png",
									}
									used = true
								elseif entname == "mobs_mc:mooshroom" then
									local droppos = vector.offset(pos, 0, 1.4, 0)
									if entity.base_texture[1] == "mobs_mc_mooshroom_brown.png" then
										minetest.add_item(droppos, mobs_mc.items.mushroom_brown .. " 5")
									else
										minetest.add_item(droppos, mobs_mc.items.mushroom_red .. " 5")
									end
									obj = mcl_util.replace_mob(obj, "mobs_mc:cow")
									entity = obj:get_luaentity()
									used = true
								end
								if used then
									obj:set_properties({ textures = texture })
									entity.gotten = true
									minetest.sound_play("mcl_tools_shears_cut", { pos = pos }, true)
									stack:add_wear(65535 / stackdef._mcl_diggroups.shearsy.uses)
									inv:set_stack("main", stack_id, stack)
									break
								end
							end
						end

					-- Spawn Egg
					elseif igroups.spawn_egg then
						-- Spawn mob
						if not dropnodedef.walkable then
							--pointed_thing = { above = droppos, under = { x=droppos.x, y=droppos.y-1, z=droppos.z } }
							minetest.add_entity(droppos, stack:get_name())

							stack:take_item()
							inv:set_stack("main", stack_id, stack)
						end

					-- Generalized dispension
					elseif (not dropnodedef.walkable or stackdef._dispense_into_walkable) then
						--[[ _on_dispense(stack, pos, droppos, dropnode, dropdir)
							* stack: Itemstack which is dispense
							* pos: Position of dispenser
							* droppos: Position to which to dispense item
							* dropnode: Node of droppos
							* dropdir: Drop direction

						_dispense_into_walkable: If true, can dispense into walkable nodes
						]]
						if stackdef._on_dispense then
							-- Item-specific dispension (if defined)
							local od_ret = stackdef._on_dispense(dropitem, pos, droppos, dropnode, dropdir)
							if od_ret then
								local newcount = stack:get_count() - 1
								stack:set_count(newcount)
								inv:set_stack("main", stack_id, stack)
								if newcount == 0 then
									inv:set_stack("main", stack_id, od_ret)
								elseif inv:room_for_item("main", od_ret) then
									inv:add_item("main", od_ret)
								else
									minetest.add_item(droppos, dropitem)
								end
							else
								stack:take_item()
								inv:set_stack("main", stack_id, stack)
							end
						else
							-- Drop item otherwise
							minetest.add_item(droppos, dropitem)
							stack:take_item()
							inv:set_stack("main", stack_id, stack)
						end
					end


				end
			end,
			rules = mesecon.rules.alldirs,
		},
	},
	on_rotate = on_rotate,
}

-- Horizontal dispenser
local horizontal_def = table.copy(dispenserdef)

function horizontal_def.after_place_node(pos, placer, itemstack, pointed_thing)
	setup_dispenser(pos)
	orientate_dispenser(pos, placer)
end

horizontal_def.tiles = {
	"default_furnace_top.png", "default_furnace_bottom.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "mcl_dispensers_dispenser_front_horizontal.png"
}
horizontal_def.paramtype2 = "facedir"

minetest.register_node("mcl_dispensers:dispenser", horizontal_def)

-- Down dispenser
local down_def = table.copy(dispenserdef)
down_def.after_place_node = setup_dispenser
down_def.tiles = {
	"default_furnace_top.png", "mcl_dispensers_dispenser_front_vertical.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "default_furnace_side.png"
}
minetest.register_node("mcl_dispensers:dispenser_down", down_def)

-- Up dispenser
-- The up dispenser is almost identical to the down dispenser , it only differs in textures
local up_def = table.copy(down_def)
up_def.tiles = {
	"mcl_dispensers_dispenser_front_vertical.png", "default_furnace_bottom.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "default_furnace_side.png"
}
minetest.register_node("mcl_dispensers:dispenser_up", up_def)
