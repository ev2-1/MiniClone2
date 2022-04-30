minetest.register_node("mcl_observers:observer", {
		is_ground_content = false,
		paramtype2 = "facedir",
		on_rotate = false,
		tiles = {
			"mcl_observers_observer_top.png^[transformR180", "default_furnace_bottom.png",
			"mcl_observers_observer_side.png", "mcl_observers_observer_side.png",
			"mcl_observers_observer_front.png", "mcl_observers_observer_back.png",
		},
	}
)

minetest.register_node("mcl_observers:observer_down", {
		is_ground_content = false,
		tiles = {
			"mcl_observers_observer_back.png", "mcl_observers_observer_front.png",
			"mcl_observers_observer_side.png^[transformR90", "mcl_observers_observer_side.png^[transformR90",
			"mcl_observers_observer_top.png", "mcl_observers_observer_top.png",
		},
	}
)

minetest.register_node("mcl_observers:observer_up", {
	is_ground_content = false,
	on_rotate = false,
	tiles = {
		"mcl_observers_observer_front.png", "mcl_observers_observer_back.png",
		"mcl_observers_observer_side.png^[transformR270", "mcl_observers_observer_side.png^[transformR270",
		"mcl_observers_observer_top.png^[transformR180", "mcl_observers_observer_top.png^[transformR180",
	}
})
