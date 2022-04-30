-- Register tree trunk (wood) and bark
local function S()
	return ""
end

local function register_tree_trunk(subname, description_trunk, description_bark, longdesc, tile_inner, tile_bark, stripped_variant)
	minetest.register_node("mcl_core:"..subname, {
		tiles = {tile_inner, tile_inner, tile_bark},
		paramtype2 = "facedir",
	})

	minetest.register_node("mcl_core:"..subname.."_bark", {
		tiles = {tile_bark},
		paramtype2 = "facedir",
	})
end

-- Register stripped trunk and stripped wood
local function register_stripped_trunk(subname, description_stripped_trunk, description_stripped_bark, longdesc, longdesc_wood, tile_stripped_inner, tile_stripped_bark)
	minetest.register_node("mcl_core:"..subname, {
		tiles = {tile_stripped_inner, tile_stripped_inner, tile_stripped_bark},
		paramtype2 = "facedir",
	})

	minetest.register_node("mcl_core:"..subname.."_bark", {
		tiles = {tile_stripped_bark},
		paramtype2 = "facedir",
	})
end

local function register_wooden_planks(subname, description, tiles)
	minetest.register_node("mcl_core:"..subname, {
		tiles = tiles,
	})
end

local function register_leaves(subname, description, longdesc, tiles, sapling, drop_apples, sapling_chances, leafdecay_distance)
	minetest.register_node("mcl_core:"..subname, {
		drawtype = "allfaces_optional",
		tiles = tiles,
		paramtype = "light",
	})
end

local function register_sapling(subname, description, longdesc, tt_help, texture, selbox)
	minetest.register_node("mcl_core:"..subname, {
		drawtype = "plantlike",
		inventory_image = texture,
		wield_image = texture,
		paramtype = "light",
		selection_box = {
			type = "fixed",
			fixed = selbox
		},
	})
end

register_tree_trunk("tree", S("Oak Wood"), S("Oak Bark"), S("The trunk of an oak tree."), "default_tree_top.png", "default_tree.png", "mcl_core:stripped_oak")
register_tree_trunk("darktree", S("Dark Oak Wood"), S("Dark Oak Bark"), S("The trunk of a dark oak tree."), "mcl_core_log_big_oak_top.png", "mcl_core_log_big_oak.png", "mcl_core:stripped_dark_oak")
register_tree_trunk("acaciatree", S("Acacia Wood"), S("Acacia Bark"), S("The trunk of an acacia."), "default_acacia_tree_top.png", "default_acacia_tree.png", "mcl_core:stripped_acacia")
register_tree_trunk("sprucetree", S("Spruce Wood"), S("Spruce Bark"), S("The trunk of a spruce tree."), "mcl_core_log_spruce_top.png", "mcl_core_log_spruce.png", "mcl_core:stripped_spruce")
register_tree_trunk("birchtree", S("Birch Wood"), S("Birch Bark"), S("The trunk of a birch tree."), "mcl_core_log_birch_top.png", "mcl_core_log_birch.png", "mcl_core:stripped_birch")
register_tree_trunk("jungletree", S("Jungle Wood"), S("Jungle Bark"), S("The trunk of a jungle tree."), "default_jungletree_top.png", "default_jungletree.png", "mcl_core:stripped_jungle")

register_stripped_trunk("stripped_oak", S("Stripped Oak Log"), S("Stripped Oak Wood"), S("The stripped trunk of an oak tree."), S("The stripped wood of an oak tree."), "mcl_core_stripped_oak_top.png", "mcl_core_stripped_oak_side.png")
register_stripped_trunk("stripped_acacia", S("Stripped Acacia Log"), S("Stripped Acacia Wood"), S("The stripped trunk of an acacia tree."), S("The stripped wood of an acacia tree."), "mcl_core_stripped_acacia_top.png", "mcl_core_stripped_acacia_side.png")
register_stripped_trunk("stripped_dark_oak", S("Stripped Dark Oak Log"), S("Stripped Dark Oak Wood"), S("The stripped trunk of a dark oak tree."), S("The stripped wood of a dark oak tree."), "mcl_core_stripped_dark_oak_top.png", "mcl_core_stripped_dark_oak_side.png")
register_stripped_trunk("stripped_birch", S("Stripped Birch Log"), S("Stripped Birch Wood"), S("The stripped trunk of a birch tree."), S("The stripped wood of a birch tree."),  "mcl_core_stripped_birch_top.png", "mcl_core_stripped_birch_side.png")
register_stripped_trunk("stripped_spruce", S("Stripped Spruce Log"), S("Stripped Spruce Wood"), S("The stripped trunk of a spruce tree."), S("The stripped wood of a spruce tree."), "mcl_core_stripped_spruce_top.png", "mcl_core_stripped_spruce_side.png")
register_stripped_trunk("stripped_jungle", S("Stripped Jungle Log"), S("Stripped Jungle Wood"), S("The stripped trunk of a jungle tree."), S("The stripped wood of a jungle tree."),"mcl_core_stripped_jungle_top.png", "mcl_core_stripped_jungle_side.png")
register_wooden_planks("wood", S("Oak Wood Planks"), {"default_wood.png"})
register_wooden_planks("darkwood", S("Dark Oak Wood Planks"), {"mcl_core_planks_big_oak.png"})
register_wooden_planks("junglewood", S("Jungle Wood Planks"), {"default_junglewood.png"})
register_wooden_planks("sprucewood", S("Spruce Wood Planks"), {"mcl_core_planks_spruce.png"})
register_wooden_planks("acaciawood", S("Acacia Wood Planks"), {"default_acacia_wood.png"})
register_wooden_planks("birchwood", S("Birch Wood Planks"), {"mcl_core_planks_birch.png"})


register_sapling("sapling", S("Oak Sapling"),
	S("When placed on soil (such as dirt) and exposed to light, an oak sapling will grow into an oak after some time."),
	S("Needs soil and light to grow"),
	"default_sapling.png", {-5/16, -0.5, -5/16, 5/16, 0.5, 5/16})
register_sapling("darksapling", S("Dark Oak Sapling"),
	S("Dark oak saplings can grow into dark oaks, but only in groups. A lonely dark oak sapling won't grow. A group of four dark oak saplings grows into a dark oak after some time when they are placed on soil (such as dirt) in a 2×2 square and exposed to light."),
	S("Needs soil and light to grow") .. "\n" .. S("2×2 saplings required"),
	"mcl_core_sapling_big_oak.png", {-5/16, -0.5, -5/16, 5/16, 7/16, 5/16})
register_sapling("junglesapling", S("Jungle Sapling"),
	S("When placed on soil (such as dirt) and exposed to light, a jungle sapling will grow into a jungle tree after some time. When there are 4 jungle saplings in a 2×2 square, they will grow to a huge jungle tree."),
	S("Needs soil and light to grow") .. "\n" .. S("2×2 saplings = large tree"),
	"default_junglesapling.png", {-5/16, -0.5, -5/16, 5/16, 0.5, 5/16})
register_sapling("acaciasapling", S("Acacia Sapling"),
	S("When placed on soil (such as dirt) and exposed to light, an acacia sapling will grow into an acacia after some time."),
	S("Needs soil and light to grow"),
	"default_acacia_sapling.png", {-5/16, -0.5, -5/16, 5/16, 4/16, 5/16})
register_sapling("sprucesapling", S("Spruce Sapling"),
	S("When placed on soil (such as dirt) and exposed to light, a spruce sapling will grow into a spruce after some time. When there are 4 spruce saplings in a 2×2 square, they will grow to a huge spruce."),
	S("Needs soil and light to grow") .. "\n" .. S("2×2 saplings = large tree"),
	"mcl_core_sapling_spruce.png", {-4/16, -0.5, -4/16, 4/16, 0.5, 4/16})
register_sapling("birchsapling", S("Birch Sapling"),
	S("When placed on soil (such as dirt) and exposed to light, a birch sapling will grow into a birch after some time."),
	S("Needs soil and light to grow"),
	"mcl_core_sapling_birch.png", {-4/16, -0.5, -4/16, 4/16, 0.5, 4/16})


register_leaves("leaves", S("Oak Leaves"), S("Oak leaves are grown from oak trees."), {"default_leaves.png"}, "mcl_core:sapling", true, {20, 16, 12, 10})
register_leaves("darkleaves", S("Dark Oak Leaves"), S("Dark oak leaves are grown from dark oak trees."), {"mcl_core_leaves_big_oak.png"}, "mcl_core:darksapling", true, {20, 16, 12, 10})
register_leaves("jungleleaves", S("Jungle Leaves"), S("Jungle leaves are grown from jungle trees."), {"default_jungleleaves.png"}, "mcl_core:junglesapling", false, {40, 26, 32, 24, 10})
register_leaves("acacialeaves", S("Acacia Leaves"), S("Acacia leaves are grown from acacia trees."), {"default_acacia_leaves.png"}, "mcl_core:acaciasapling", false, {20, 16, 12, 10})
register_leaves("spruceleaves", S("Spruce Leaves"), S("Spruce leaves are grown from spruce trees."), {"mcl_core_leaves_spruce.png"}, "mcl_core:sprucesapling", false, {20, 16, 12, 10})
register_leaves("birchleaves", S("Birch Leaves"), S("Birch leaves are grown from birch trees."), {"mcl_core_leaves_birch.png"}, "mcl_core:birchsapling", false, {20, 16, 12, 10})



-- Node aliases

minetest.register_alias("default:acacia_tree", "mcl_core:acaciatree")
minetest.register_alias("default:acacia_leaves", "mcl_core:acacialeaves")
