local boxes = { -8/16, -8/16, -8/16,  8/16, -2/16, 8/16 }

-- Daylight Sensor
minetest.register_node("mesecons_solarpanel:solar_panel_on", {
	drawtype = "nodebox",
	tiles = { "jeija_solar_panel.png","jeija_solar_panel.png","jeija_solar_panel_side.png",
	"jeija_solar_panel_side.png","jeija_solar_panel_side.png","jeija_solar_panel_side.png", },
	wield_image = "jeija_solar_panel.png",
	wield_scale = { x=1, y=1, z=3 },
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = boxes
	},
	node_box = {
		type = "fixed",
		fixed = boxes
	},
	drop = "mesecons_solarpanel:solar_panel_off",
})

minetest.register_node("mesecons_solarpanel:solar_panel_off", {
	drawtype = "nodebox",
	tiles = { "jeija_solar_panel.png","jeija_solar_panel.png","jeija_solar_panel_side.png",
	"jeija_solar_panel_side.png","jeija_solar_panel_side.png","jeija_solar_panel_side.png", },
	wield_image = "jeija_solar_panel.png",
	wield_scale = { x=1, y=1, z=3 },
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = boxes
	},
	node_box = {
		type = "fixed",
		fixed = boxes
	},
})

--- Inverted Daylight Sensor

minetest.register_node("mesecons_solarpanel:solar_panel_inverted_on", {
	drawtype = "nodebox",
	tiles = { "jeija_solar_panel_inverted.png","jeija_solar_panel_inverted.png","jeija_solar_panel_side.png",
	"jeija_solar_panel_side.png","jeija_solar_panel_side.png","jeija_solar_panel_side.png", },
	wield_image = "jeija_solar_panel_inverted.png",
	wield_scale = { x=1, y=1, z=3 },
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = boxes
	},
	node_box = {
		type = "fixed",
		fixed = boxes
	},
	drop = "mesecons_solarpanel:solar_panel_off",
})

minetest.register_node("mesecons_solarpanel:solar_panel_inverted_off", {
	drawtype = "nodebox",
	tiles = { "jeija_solar_panel_inverted.png","jeija_solar_panel_inverted.png","jeija_solar_panel_side.png",
	"jeija_solar_panel_side.png","jeija_solar_panel_side.png","jeija_solar_panel_side.png", },
	wield_image = "jeija_solar_panel_inverted.png",
	wield_scale = { x=1, y=1, z=3 },
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = boxes
	},
	node_box = {
		type = "fixed",
		fixed = boxes
	},
})
