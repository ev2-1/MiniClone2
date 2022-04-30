local open_barrels = {}

minetest.register_node("mcl_barrels:barrel_closed", {
	tiles = {"mcl_barrels_barrel_top.png^[transformR270", "mcl_barrels_barrel_bottom.png", "mcl_barrels_barrel_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
})

minetest.register_node("mcl_barrels:barrel_open", {
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "mcl_barrels:barrel_closed",
	stack_max = 64,
})
