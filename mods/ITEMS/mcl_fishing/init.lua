--Fishing Rod, Bobber, and Flying Bobber mechanics and Bobber artwork by Rootyjr.

local bobber_ENTITY={
	physical = false,
	timer=0,
	textures = {"mcl_fishing_bobber.png"},
	visual_size = {x=0.5, y=0.5},
	collisionbox = {0.45,0.45,0.45,0.45,0.45,0.45},
	pointable = false,
	static_save = false,

	_lastpos={},
	_dive = false,
	_waittime = nil,
	_time = 0,
	player=nil,
	_oldy = nil,
	objtype="fishing",
}

local flying_bobber_ENTITY={
	physical = false,
	timer=0,
	textures = {"mcl_fishing_bobber.png"}, --FIXME: Replace with correct texture.
	visual_size = {x=0.5, y=0.5},
	collisionbox = {0,0,0,0,0,0},
	pointable = false,

	_lastpos={},
	_thrower = nil,
	objtype="fishing",
}

minetest.register_entity("mcl_fishing:flying_bobber_entity", flying_bobber_ENTITY)

-- Fishing Rod
minetest.register_tool("mcl_fishing:fishing_rod", {
	inventory_image = "mcl_fishing_fishing_rod.png",
	wield_image = "mcl_fishing_fishing_rod.png^[transformR270",
	wield_scale = { x = 1.5, y = 1.5, z = 1 },
})

-- Fish
minetest.register_craftitem("mcl_fishing:fish_raw", {
	inventory_image = "mcl_fishing_fish_raw.png",
})

minetest.register_craftitem("mcl_fishing:fish_cooked", {
	inventory_image = "mcl_fishing_fish_cooked.png",
})

-- Salmon
minetest.register_craftitem("mcl_fishing:salmon_raw", {
	inventory_image = "mcl_fishing_salmon_raw.png",
})

minetest.register_craftitem("mcl_fishing:salmon_cooked", {
	inventory_image = "mcl_fishing_salmon_cooked.png",
})

-- Clownfish
minetest.register_craftitem("mcl_fishing:clownfish_raw", {
	inventory_image = "mcl_fishing_clownfish_raw.png",
})

minetest.register_craftitem("mcl_fishing:pufferfish_raw", {
	inventory_image = "mcl_fishing_pufferfish_raw.png",
})
