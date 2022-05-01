local pt = 4/16 -- pusher thickness

local piston_pusher_box = {
	type = "fixed",
	fixed = {
		{-2/16, -2/16, -.5 + pt, 2/16, 2/16,  .5 + pt},
		{-.5  , -.5  , -.5     , .5  , .5  , -.5 + pt},
	},
}

local piston_on_box = {
	type = "fixed",
	fixed = {
		{-.5, -.5, -.5 + pt, .5, .5, .5}
	},
}


-- Normal (non-sticky) ones:


-- offstate
minetest.register_node("mesecons_pistons:piston_normal_off", {
	tiles = {
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png^[transformR90",
		"mesecons_piston_bottom.png^[transformR270",
		"mesecons_piston_back.png",
		"mesecons_piston_pusher_front.png"
	},
	groups = {handy=1, piston=1},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- onstate
minetest.register_node("mesecons_pistons:piston_normal_on", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png^[transformR90",
		"mesecons_piston_bottom.png^[transformR270",
		"mesecons_piston_back.png",
		"mesecons_piston_on_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- pusher
minetest.register_node("mesecons_pistons:piston_pusher_normal", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_pusher_top.png",
		"mesecons_piston_pusher_bottom.png",
		"mesecons_piston_pusher_left.png",
		"mesecons_piston_pusher_right.png",
		"mesecons_piston_pusher_back.png",
		"mesecons_piston_pusher_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
	selection_box = piston_pusher_box,
	node_box = piston_pusher_box,
	sounds = mcl_sounds.node_sound_wood_defaults(),
})

-- Sticky ones
local pistonspec_sticky = {
	offname = "mesecons_pistons:piston_sticky_off",
	onname = "mesecons_pistons:piston_sticky_on",
	pusher = "mesecons_pistons:piston_pusher_sticky",
	sticky = true,
	piston_down = "mesecons_pistons:piston_down_sticky_off",
	piston_up   = "mesecons_pistons:piston_up_sticky_off",
}

-- offstate
minetest.register_node("mesecons_pistons:piston_sticky_off", {
	tiles = {
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png^[transformR90",
		"mesecons_piston_bottom.png^[transformR270",
		"mesecons_piston_back.png",
		"mesecons_piston_pusher_front_sticky.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- onstate
minetest.register_node("mesecons_pistons:piston_sticky_on", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png^[transformR90",
		"mesecons_piston_bottom.png^[transformR270",
		"mesecons_piston_back.png",
		"mesecons_piston_on_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	node_box = piston_on_box,
	selection_box = piston_on_box,
})

-- pusher
minetest.register_node("mesecons_pistons:piston_pusher_sticky", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_pusher_top.png",
		"mesecons_piston_pusher_bottom.png",
		"mesecons_piston_pusher_left.png",
		"mesecons_piston_pusher_right.png",
		"mesecons_piston_pusher_back.png",
		"mesecons_piston_pusher_front_sticky.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	diggable = false,
	selection_box = piston_pusher_box,
	node_box = piston_pusher_box,
})

--
--
-- UP
--
--

local piston_up_pusher_box = {
	type = "fixed",
	fixed = {
		{-2/16, -.5 - pt, -2/16, 2/16, .5 - pt, 2/16},
		{-.5  ,  .5 - pt, -.5  , .5  , .5     ,   .5},
	},
}

local piston_up_on_box = {
	type = "fixed",
	fixed = {
		{-.5, -.5, -.5 , .5, .5-pt, .5}
	},
}

-- Normal

-- offstate
minetest.register_node("mesecons_pistons:piston_up_normal_off", {
	tiles = {
		"mesecons_piston_pusher_front.png",
		"mesecons_piston_back.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- onstate
minetest.register_node("mesecons_pistons:piston_up_normal_on", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_on_front.png",
		"mesecons_piston_back.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	node_box = piston_up_on_box,
	selection_box = piston_up_on_box,
})

-- pusher
minetest.register_node("mesecons_pistons:piston_up_pusher_normal", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_pusher_front.png",
		"mesecons_piston_pusher_back.png",
		"mesecons_piston_pusher_left.png^[transformR270",
		"mesecons_piston_pusher_right.png^[transformR90",
		"mesecons_piston_pusher_bottom.png",
		"mesecons_piston_pusher_top.png^[transformR180",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
})



-- Sticky
-- offstate
minetest.register_node("mesecons_pistons:piston_up_sticky_off", {
	tiles = {
		"mesecons_piston_pusher_front_sticky.png",
		"mesecons_piston_back.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- onstate
minetest.register_node("mesecons_pistons:piston_up_sticky_on", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_on_front.png",
		"mesecons_piston_back.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
		"mesecons_piston_bottom.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	node_box = piston_up_on_box,
	selection_box = piston_up_on_box,
})

-- pusher
minetest.register_node("mesecons_pistons:piston_up_pusher_sticky", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_pusher_front_sticky.png",
		"mesecons_piston_pusher_back.png",
		"mesecons_piston_pusher_left.png^[transformR270",
		"mesecons_piston_pusher_right.png^[transformR90",
		"mesecons_piston_pusher_bottom.png",
		"mesecons_piston_pusher_top.png^[transformR180",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
	selection_box = piston_up_pusher_box,
	node_box = piston_up_pusher_box,
})

--
--
-- DOWN
--
--

local piston_down_pusher_box = {
	type = "fixed",
	fixed = {
		{-2/16, -.5 + pt, -2/16, 2/16,  .5 + pt, 2/16},
		{-.5  , -.5     , -.5  , .5  , -.5 + pt,   .5},
	},
}

local piston_down_on_box = {
	type = "fixed",
	fixed = {
		{-.5, -.5+pt, -.5 , .5, .5, .5}
	},
}



-- Normal
-- offstate
minetest.register_node("mesecons_pistons:piston_down_normal_off", {
	tiles = {
		"mesecons_piston_back.png",
		"mesecons_piston_pusher_front.png",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- onstate
minetest.register_node("mesecons_pistons:piston_down_normal_on", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_back.png",
		"mesecons_piston_on_front.png",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	node_box = piston_down_on_box,
	selection_box = piston_down_on_box,
})

-- pusher
minetest.register_node("mesecons_pistons:piston_down_pusher_normal", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_pusher_back.png",
		"mesecons_piston_pusher_front.png",
		"mesecons_piston_pusher_left.png^[transformR90",
		"mesecons_piston_pusher_right.png^[transformR270",
		"mesecons_piston_pusher_bottom.png^[transformR180",
		"mesecons_piston_pusher_top.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	diggable = false,
	selection_box = piston_down_pusher_box,
	node_box = piston_down_pusher_box,
	on_rotate = false,
})

-- Sticky
-- offstate
minetest.register_node("mesecons_pistons:piston_down_sticky_off", {
	tiles = {
		"mesecons_piston_back.png",
		"mesecons_piston_pusher_front_sticky.png",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
})

-- onstate
minetest.register_node("mesecons_pistons:piston_down_sticky_on", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_back.png",
		"mesecons_piston_on_front.png",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
		"mesecons_piston_bottom.png^[transformR180",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	node_box = piston_down_on_box,
	selection_box = piston_down_on_box,
})

-- pusher
minetest.register_node("mesecons_pistons:piston_down_pusher_sticky", {
	drawtype = "nodebox",
	tiles = {
		"mesecons_piston_pusher_back.png",
		"mesecons_piston_pusher_front_sticky.png",
		"mesecons_piston_pusher_left.png^[transformR90",
		"mesecons_piston_pusher_right.png^[transformR270",
		"mesecons_piston_pusher_bottom.png^[transformR180",
		"mesecons_piston_pusher_top.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {piston_pusher=2},
	is_ground_content = false,
	diggable = false,
	selection_box = piston_down_pusher_box,
	node_box = piston_down_pusher_box,
})

-- Add entry aliases for the Help
if minetest.get_modpath("doc") then
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_normal_on")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_up_normal_off")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_up_normal_on")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_down_normal_off")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_down_normal_on")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_pusher_normal")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_up_pusher_normal")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_normal_off", "nodes", "mesecons_pistons:piston_down_pusher_normal")

	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_sticky_on")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_up_sticky_off")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_up_sticky_on")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_down_sticky_off")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_down_sticky_on")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_pusher_sticky")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_up_pusher_sticky")
	doc.add_entry_alias("nodes", "mesecons_pistons:piston_sticky_off", "nodes", "mesecons_pistons:piston_down_pusher_sticky")
end

