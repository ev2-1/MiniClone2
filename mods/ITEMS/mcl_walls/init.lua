mcl_walls = {}

local function rshift(x, by)
	return math.floor(x / 2 ^ by)
end

local directions = {
	{x = 1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = -1, y = 0, z = 0},
	{x = 0, y = 0, z = -1},
	{x = 0, y = -1, z = 0},
}

local function update_wall(pos)
	local thisnode = minetest.get_node(pos)

	if minetest.get_item_group(thisnode.name, "wall") == 0 then
		return
	end

	-- Get the node's base name, including the underscore since we will need it
	local colonpos = thisnode.name:find(":")
	local underscorepos
	local itemname, basename, modname
	if colonpos ~= nil then
		itemname = thisnode.name:sub(colonpos+1)
		modname = thisnode.name:sub(1, colonpos-1)
	end
	underscorepos = itemname:find("_")
	if underscorepos == nil then -- New wall
		basename = thisnode.name .. "_"
	else -- Already placed wall
		basename = modname .. ":" .. itemname:sub(1, underscorepos)
	end

	local sum = 0

	-- Neighbouring walkable nodes
	for i = 1, 4 do
		local dir = directions[i]
		local node = minetest.get_node({x = pos.x + dir.x, y = pos.y + dir.y, z = pos.z + dir.z})
		if minetest.registered_nodes[node.name].walkable then
			sum = sum + 2 ^ (i - 1)
		end
	end

	-- Torches or walkable nodes above the wall
	local upnode = minetest.get_node({x = pos.x, y = pos.y+1, z = pos.z})
	if sum == 5 or sum == 10 then
		if minetest.registered_nodes[upnode.name].walkable or upnode.name == "mcl_torches:floor" then
			sum = sum + 11
		end
	end

	--[[if sum == 0 then
		sum = 15
	end]]

	minetest.add_node(pos, {name = basename..sum})
end

local function update_wall_global(pos)
	for i = 1,5 do
		local dir = directions[i]
		update_wall({x = pos.x + dir.x, y = pos.y + dir.y, z = pos.z + dir.z})
	end
end

local half_blocks = {
    {4/16, -0.5, -3/16, 0.5, 5/16, 3/16},
    {-3/16, -0.5, 4/16, 3/16, 5/16, 0.5},
    {-0.5, -0.5, -3/16, -4/16, 5/16, 3/16},
    {-3/16, -0.5, -0.5, 3/16, 5/16, -4/16}
}

local pillar = {-4/16, -0.5, -4/16, 4/16, 0.5, 4/16}

local full_blocks = {
    {-0.5, -0.5, -3/16, 0.5, 5/16, 3/16},
    {-3/16, -0.5, -0.5, 3/16, 5/16, 0.5}
}

--[[ Adds a new wall type.
* nodename: Itemstring of base node to add. Must not contain an underscore
* description: Item description (tooltip), visible to user
* tiles: Wall textures table
* inventory_image: Inventory image (optional)
* groups: Base group memberships (optional, default is {cracky=3})
* sounds: Sound table (optional, default is stone)
]]
function mcl_walls.register_wall(nodename, description, tiles, inventory_image, groups, sounds)

	local base_groups = groups
	if not base_groups then
		base_groups = {cracky=3}
	end
	base_groups.wall = 1

	internal_groups = table.copy(base_groups)
	internal_groups.not_in_creative_inventory = 1

	main_node_groups = table.copy(base_groups)
	main_node_groups.deco_block = 1

	if not sounds then
		sounds = mcl_sounds.node_sound_stone_defaults()
	end

	for i = 0, 15 do
		local need = {}
		local need_pillar = false
		for j = 1, 4 do
			if rshift(i, j - 1) % 2 == 1 then
				need[j] = true
			end
		end

		local take = {}
		if need[1] == true and need[3] == true then
			need[1] = nil
			need[3] = nil
			table.insert(take, full_blocks[1])
		end
		if need[2] == true and need[4] == true then
			need[2] = nil
			need[4] = nil
			table.insert(take, full_blocks[2])
		end
		for k in pairs(need) do
			table.insert(take, half_blocks[k])
			need_pillar = true
		end
		if i == 15 or i == 0 then need_pillar = true end
		if need_pillar then table.insert(take, pillar) end

		minetest.register_node(nodename.."_"..i, {
			collision_box = {
				type = 'fixed', 
				fixed = {-4/16, -0.5, -4/16, 4/16, 1, 4/16}
			},
			drawtype = "nodebox",
			is_ground_content = false,
			tiles = tiles,
			paramtype = "light",
			groups = internal_groups,
			drop = nodename,
			node_box = {
				type = "fixed",
				fixed = take
			},
			sounds = sounds,
		})
	end

	minetest.register_node(nodename.."_16", {
		drawtype = "nodebox",
		collision_box = {
				type = 'fixed', 
				fixed = {-4/16, -0.5, -4/16, 4/16, 1, 4/16}
		},
		tiles = tiles,
		paramtype = "light",
		is_ground_content = false,
		groups = internal_groups,
		drop = nodename,
		node_box = {
			type = "fixed",
			fixed = {pillar, full_blocks[1]}
		},
		sounds = sounds,
	})

	minetest.register_node(nodename.."_21", {
		drawtype = "nodebox",
		collision_box = {
				type = 'fixed', 
				fixed = {-4/16, -0.5, -4/16, 4/16, 1, 4/16}
		},
		tiles = tiles,
		paramtype = "light",
		is_ground_content = false,
		groups = internal_groups,
		drop = nodename,
		node_box = {
			type = "fixed",
			fixed = {pillar, full_blocks[2]}
		},
		sounds = sounds,
	})

	-- Inventory item
	minetest.register_node(nodename, {
		description = description,
		paramtype = "light",
		is_ground_content = false,
		groups = main_node_groups,
		tiles = tiles,
		inventory_image = inventory_image,
		stack_max = 64,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = pillar
		},
		collision_box = {
				type = 'fixed', 
				fixed = {-4/16, -0.5, -4/16, 4/16, 1, 4/16}
		},
		collisionbox = {-0.2, 0, -0.2, 0.2, 1.4, 0.2},
		on_construct = update_wall,
		sounds = sounds,
	})
end

-- Cobblestone wall

mcl_walls.register_wall("mcl_walls:cobble", "Cobblestone Wall", {"default_cobble.png"}, "mcl_walls_cobble.png")
minetest.register_craft({
	output = 'mcl_walls:cobble 6',
	recipe = {
		{'mcl_core:cobble', 'mcl_core:cobble', 'mcl_core:cobble'},
		{'mcl_core:cobble', 'mcl_core:cobble', 'mcl_core:cobble'}
	}
})

-- Mossy wall

mcl_walls.register_wall("mcl_walls:mossycobble", "Mossy Cobblestone Wall", {"default_mossycobble.png"}, "mcl_walls_mossycobble.png")
minetest.register_craft({
	output = 'mcl_walls:mossycobble 6',
	recipe = {
		{'mcl_core:mossycobble', 'mcl_core:mossycobble', 'mcl_core:mossycobble'},
        {'mcl_core:mossycobble', 'mcl_core:mossycobble', 'mcl_core:mossycobble'}
	}
})

minetest.register_on_placenode(update_wall_global)
minetest.register_on_dignode(update_wall_global)
