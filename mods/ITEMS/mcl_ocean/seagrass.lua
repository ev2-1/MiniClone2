-- List of supported surfaces for seagrass
local surfaces = {
	{ "dirt", "mcl_core:dirt" },
	{ "sand", "mcl_core:sand", 1 },
	{ "redsand", "mcl_core:redsand", 1 },
	{ "gravel", "mcl_core:gravel", 1 },
}

-- Seagrass nodes: seagrass on a surface node

for s=1, #surfaces do
	local def = minetest.registered_nodes[surfaces[s][2]]
	local alt
	if surfaces[s][3] == 1 then
		alt = surfaces[s][2]
	end

	local doc_longdesc, doc_img, desc
	if surfaces[s][1] == "dirt" then
		doc_create = true
		doc_img = "mcl_ocean_seagrass.png^[verticalframe:12:0"
	else
		doc_create = false
	end

	minetest.register_node("mcl_ocean:seagrass_"..surfaces[s][1], {
		drawtype = "plantlike_rooted",
		paramtype = "light",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = def.tiles,
		special_tiles = {
			{
			image = "mcl_ocean_seagrass.png",
			animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0},
			}
		},
		inventory_image = "("..def.tiles[1]..")^(mcl_ocean_seagrass.png^[verticalframe:12:0)",
		wield_image = "mcl_ocean_seagrass.png^[verticalframe:12:0",
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
				{ -0.5, 0.5, -0.5, 0.5, 1.3, 0.5 },
			},
		},
	})
end

