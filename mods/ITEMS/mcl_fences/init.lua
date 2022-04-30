-- Node box
local p = {-2/16, -0.5, -2/16, 2/16, 0.5, 2/16}
local x1 = {-0.5, 4/16, -1/16, -2/16, 7/16, 1/16}   --oben(quer) -x
local x12 = {-0.5, -2/16, -1/16, -2/16, 1/16, 1/16} --unten(quer) -x
local x2 = {2/16, 4/16, -1/16, 0.5, 7/16, 1/16}   --oben(quer) x
local x22 = {2/16, -2/16, -1/16, 0.5, 1/16, 1/16} --unten(quer) x
local z1 = {-1/16, 4/16, -0.5, 1/16, 7/16, -2/16}   --oben(quer) -z
local z12 = {-1/16, -2/16, -0.5, 1/16, 1/16, -2/16} --unten(quer) -z
local z2 = {-1/16, 4/16, 2/16, 1/16, 7/16, 0.5}   --oben(quer) z
local z22 = {-1/16, -2/16, 2/16, 1/16, 1/16, 0.5} --unten(quer) z

-- Collision box
local cp = {-2/16, -0.5, -2/16, 2/16, 1.01, 2/16}
local cx1 = {-0.5, -0.5, -2/16, -2/16, 1.01, 2/16} --unten(quer) -x
local cx2 = {2/16, -0.5, -2/16, 0.5, 1.01, 2/16} --unten(quer) x
local cz1 = {-2/16, -0.5, -0.5, 2/16, 1.01, -2/16} --unten(quer) -z
local cz2 = {-2/16, -0.5, 2/16, 2/16, 1.01, 0.5} --unten(quer) z

mcl_fences = {}

function mcl_fences.register_fence(id, texture)
	local fence_id = minetest.get_current_modname()..":"..id
	minetest.register_node(fence_id, {
		tiles = {texture},
		inventory_image = "mcl_fences_fence_mask.png^" .. texture .. "^mcl_fences_fence_mask.png^[makealpha:255,126,126",
		wield_image = "mcl_fences_fence_mask.png^" .. texture .. "^mcl_fences_fence_mask.png^[makealpha:255,126,126",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {p},
			connect_front = {z1,z12},
			connect_back = {z2,z22,},
			connect_left = {x1,x12},
			connect_right = {x2,x22},
		},
		collision_box = {
			type = "connected",
			fixed = {cp},
			connect_front = {cz1},
			connect_back = {cz2,},
			connect_left = {cx1},
			connect_right = {cx2},
		},
	})

	return fence_id
end

function mcl_fences.register_fence_gate(id, texture)
	local gate_id = minetest.get_current_modname()..":"..id.."_gate"
	local open_gate_id = gate_id .. "_open"

	minetest.register_node(open_gate_id, {
		tiles = {texture},
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		sunlight_propagates = true,
		walkable = false,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -3/16, -1/16, -6/16, 0.5, 1/16},   --links abschluss
				{6/16, -3/16, -1/16, 0.5, 0.5, 1/16},   --rechts abschluss
				{-0.5, 4/16, 1/16, -6/16, 7/16, 6/16},   --oben-links(quer) x
				{-0.5, -2/16, 1/16, -6/16, 1/16, 6/16}, --unten-links(quer) x
				{6/16, 4/16, 1/16, 0.5, 7/16, 0.5},   --oben-rechts(quer) x
				{6/16, -2/16, 1/16, 0.5, 1/16, 0.5}, --unten-rechts(quer) x
				{-0.5, -2/16, 6/16, -6/16, 7/16, 0.5},  --mitte links
				{6/16, 1/16, 0.5, 0.5, 4/16, 6/16},  --mitte rechts
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -3/16, -1/16, 0.5, 0.5, 1/16},   --gate
				}
		},
	})

	minetest.register_node(gate_id, {
		tiles = {texture},
		inventory_image = "mcl_fences_fence_gate_mask.png^" .. texture .. "^mcl_fences_fence_gate_mask.png^[makealpha:255,126,126",
		wield_image = "mcl_fences_fence_gate_mask.png^" .. texture .. "^mcl_fences_fence_gate_mask.png^[makealpha:255,126,126",
		paramtype = "light",
		is_ground_content = false,
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = true,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -3/16, -1/16, -6/16, 0.5, 1/16},   --links abschluss
				{6/16, -3/16, -1/16, 0.5, 0.5, 1/16},   --rechts abschluss
				{-2/16, -2/16, -1/16, 0, 7/16, 1/16},  --mitte links
				{0, -2/16, -1/16, 2/16, 7/16, 1/16},  --mitte rechts
				{-0.5, 4/16, -1/16, -2/16, 7/16, 1/16},   --oben(quer) -z
				{-0.5, -2/16, -1/16, -2/16, 1/16, 1/16}, --unten(quer) -z
				{2/16, 4/16, -1/16, 0.5, 7/16, 1/16},   --oben(quer) z
				{2/16, -2/16, -1/16, 0.5, 1/16, 1/16}, --unten(quer) z
			}
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -3/16, -2/16, 0.5, 1, 2/16},   --gate
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -3/16, -1/16, 0.5, 0.5, 1/16},   --gate
			}
		},
	})

	return gate_id, open_gate_id
end

function mcl_fences.register_fence_and_fence_gate(id, texture_fence, texture_fence_gate)
	local fence_id = mcl_fences.register_fence(id, texture_fence)
	local gate_id, open_gate_id = mcl_fences.register_fence_gate(id, texture_fence_gate)

	return fence_id, gate_id, open_gate_id
end

local wood_groups = {handy=1,axey=1, flammable=2,fence_wood=1, fire_encouragement=5, fire_flammability=20}
local wood_connect = {"group:fence_wood"}
local wood_sounds = mcl_sounds.node_sound_wood_defaults()

local woods = {
	{"", "mcl_fences_fence_oak.png", "mcl_fences_fence_gate_oak.png"},
	{"spruce", "mcl_fences_fence_spruce.png", "mcl_fences_fence_gate_spruce.png"},
	{"birch", "mcl_fences_fence_birch.png", "mcl_fences_fence_gate_birch.png"},
	{"jungle", "mcl_fences_fence_jungle.png", "mcl_fences_fence_gate_jungle.png"},
	{"dark_oak", "mcl_fences_fence_big_oak.png", "mcl_fences_fence_gate_big_oak.png"},
	{"acacia", "mcl_fences_fence_acacia.png", "mcl_fences_fence_gate_acacia.png"},
}

for w=1, #woods do
	local wood = woods[w]
	local id, id_gate
	if wood[1] == "" then
		id = "fence"
		id_gate = "fence_gate"
	else
		id = wood[1].."_fence"
		id_gate = wood[1].."_fence_gate"
	end
	mcl_fences.register_fence_and_fence_gate(id, wood[2], wood[3])
end


-- Nether Brick Fence (without fence gate!)
mcl_fences.register_fence("nether_brick_fence", "mcl_fences_fence_nether_brick.png")

minetest.register_craft({
	output = "mcl_fences:nether_brick_fence 6",
	recipe = {
		{"mcl_nether:nether_brick", "mcl_nether:netherbrick", "mcl_nether:nether_brick"},
		{"mcl_nether:nether_brick", "mcl_nether:netherbrick", "mcl_nether:nether_brick"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:fence_wood",
	burntime = 15,
})
