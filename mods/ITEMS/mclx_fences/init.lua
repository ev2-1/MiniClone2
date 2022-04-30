local S = minetest.get_translator(minetest.get_current_modname())

-- Red Nether Brick Fence

mcl_fences.register_fence_and_fence_gate(
	"red_nether_brick_fence",
	"mcl_fences_fence_red_nether_brick.png",
	"mcl_fences_fence_gate_red_nether_brick.png")

mcl_fences.register_fence_gate(
	"nether_brick_fence",
	"mcl_fences_fence_gate_nether_brick.png")

-- Crafting

minetest.register_craft({
	output = "mclx_fences:red_nether_brick_fence 6",
	recipe = {
		{"mcl_nether:red_nether_brick", "mcl_nether:netherbrick", "mcl_nether:red_nether_brick"},
		{"mcl_nether:red_nether_brick", "mcl_nether:netherbrick", "mcl_nether:red_nether_brick"},
	}
})

minetest.register_craft({
	output = "mclx_fences:red_nether_brick_fence_gate",
	recipe = {
		{"mcl_nether:nether_wart_item", "mcl_nether:red_nether_brick", "mcl_nether:netherbrick"},
		{"mcl_nether:netherbrick", "mcl_nether:red_nether_brick", "mcl_nether:nether_wart_item"},
	}
})
minetest.register_craft({
	output = "mclx_fences:red_nether_brick_fence_gate",
	recipe = {
		{"mcl_nether:netherbrick", "mcl_nether:red_nether_brick", "mcl_nether:nether_wart_item"},
		{"mcl_nether:nether_wart_item", "mcl_nether:red_nether_brick", "mcl_nether:netherbrick"},
	}
})

minetest.register_craft({
	output = "mclx_fences:nether_brick_fence_gate 2",
	recipe = {
		{"mcl_nether:netherbrick", "mcl_nether:nether_brick", "mcl_nether:netherbrick"},
		{"mcl_nether:netherbrick", "mcl_nether:nether_brick", "mcl_nether:netherbrick"},
	}
})


-- Aliases for mcl_supplemental
minetest.register_alias("mcl_supplemental:red_nether_brick_fence", "mclx_fences:red_nether_brick_fence")

minetest.register_alias("mcl_supplemental:nether_brick_fence_gate", "mclx_fences:nether_brick_fence_gate")
minetest.register_alias("mcl_supplemental:nether_brick_fence_gate_open", "mclx_fences:nether_brick_fence_gate_open")

minetest.register_alias("mcl_supplemental:red_nether_brick_fence_gate", "mclx_fences:red_nether_brick_fence_gate")
minetest.register_alias("mcl_supplemental:red_nether_brick_fence_gate_open", "mclx_fences:red_nether_brick_fence_gate_open")
