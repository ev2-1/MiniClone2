
-- ############################
-- ## Wire node registration ##
-- ############################
-- Nodeboxes:
local box_center = {-1/16, -.5, -1/16, 1/16, -.5+1/64, 1/16}
local box_bump1 =  { -2/16, -8/16,  -2/16, 2/16, -.5+1/64, 2/16 }

local nbox_nid =
{
	[0] = {1/16, -.5, -1/16, 8/16, -.5+1/64, 1/16}, -- x positive
	[1] = {-1/16, -.5, 1/16, 1/16, -.5+1/64, 8/16}, -- z positive
	[2] = {-8/16, -.5, -1/16, -1/16, -.5+1/64, 1/16}, -- x negative
	[3] = {-1/16, -.5, -8/16, 1/16, -.5+1/64, -1/16}, -- z negative

	[4] = {.5-1/16, -.5+1/16, -1/16, .5, .4999+1/64, 1/16}, -- x positive up
	[5] = {-1/16, -.5+1/16, .5-1/16, 1/16, .4999+1/64, .5}, -- z positive up
	[6] = {-.5, -.5+1/16, -1/16, -.5+1/16, .4999+1/64, 1/16}, -- x negative up
	[7] = {-1/16, -.5+1/16, -.5, 1/16, .4999+1/64, -.5+1/16}  -- z negative up
}

local selectionbox =
{
	type = "fixed",
	fixed = {-.5, -.5, -.5, .5, -.5+1/16, .5}
}

-- go to the next nodeid (ex.: 01000011 --> 01000100)
local function nid_inc() end
function nid_inc(nid)
	local i = 0
	while nid[i-1] ~= 1 do
		nid[i] = (nid[i] ~= 1) and 1 or 0
		i = i + 1
	end

	-- BUT: Skip impossible nodeids:
	if ((nid[0] == 0 and nid[4] == 1) or (nid[1] == 0 and nid[5] == 1)
	or (nid[2] == 0 and nid[6] == 1) or (nid[3] == 0 and nid[7] == 1)) then
		return nid_inc(nid)
	end

	return i <= 8
end

local function register_wires()
	local nid = {}
	while true do
		-- Create group specifiction and nodeid string (see note above for details)
		local nodeid = 	  (nid[0] or "0")..(nid[1] or "0")..(nid[2] or "0")..(nid[3] or "0")
				..(nid[4] or "0")..(nid[5] or "0")..(nid[6] or "0")..(nid[7] or "0")

		-- Calculate nodebox
		local nodebox = {type = "fixed", fixed={box_center}}
		for i=0,7 do
			if nid[i] == 1 then
				table.insert(nodebox.fixed, nbox_nid[i])
			end
		end

		-- Add bump to nodebox if curved
		if (nid[0] == 1 and nid[1] == 1) or (nid[1] == 1 and nid[2] == 1)
		or (nid[2] == 1 and nid[3] == 1) or (nid[3] == 1 and nid[0] == 1) then
			table.insert(nodebox.fixed, box_bump1)
		end

		-- If nothing to connect to, still make a nodebox of a straight wire
		if nodeid == "00000000" then
			nodebox.fixed = {-8/16, -.5, -1/16, 8/16, -.5+1/16, 1/16}
		end

		local meseconspec_off = { conductor = {
			rules = wire_rules,
			state = "on",
			onstate = "mesecons:wire_"..nodeid.."_on"
		}}

		local meseconspec_on = { conductor = {
			rules = wire_rules,
			state = "on",
			offstate = "mesecons:wire_"..nodeid.."_off"
		}}

		-- Wire textures
		local ratio_off = 128
		local ratio_on = 192
		local crossing_off = "(redstone_redstone_dust_dot.png^redstone_redstone_dust_line0.png^(redstone_redstone_dust_line1.png^[transformR90))^[colorize:#FF0000:"..ratio_off
		local crossing_on = "(redstone_redstone_dust_dot.png^redstone_redstone_dust_line0.png^(redstone_redstone_dust_line1.png^[transformR90))^[colorize:#FF0000:"..ratio_on
		local straight0_off = "redstone_redstone_dust_line0.png^[colorize:#FF0000:"..ratio_off
		local straight0_on = "redstone_redstone_dust_line0.png^[colorize:#FF0000:"..ratio_on
		local straight1_off = "redstone_redstone_dust_line0.png^[colorize:#FF0000:"..ratio_off
		local straight1_on = "redstone_redstone_dust_line0.png^[colorize:#FF0000:"..ratio_on
		local dot_off = "redstone_redstone_dust_dot.png^[colorize:#FF0000:"..ratio_off
		local dot_on = "redstone_redstone_dust_dot.png^[colorize:#FF0000:"..ratio_on

		local tiles_off, tiles_on

		local wirehelp, tt, longdesc, usagehelp, img, desc_off, desc_on
		if nodeid == "00000000" then
			-- Non-connected redstone wire
			nodebox.fixed = {-8/16, -.5, -8/16, 8/16, -.5+1/64, 8/16}
			-- “Dot” texture
			tiles_off = { dot_off, dot_off, "blank.png", "blank.png", "blank.png", "blank.png" }
			tiles_on = { dot_on, dot_on, "blank.png", "blank.png", "blank.png", "blank.png" }
		else
			-- Connected redstone wire
			table.insert(nodebox, box_center)
			tiles_off = { crossing_off, crossing_off, straight0_off, straight1_off, straight0_off, straight1_off }
			tiles_on = { crossing_on, crossing_on, straight0_on, straight1_on, straight0_on, straight1_on }
			wirehelp = false
		end

		minetest.register_node(":mesecons:wire_"..nodeid, {
			drawtype = "nodebox",
			paramtype = "light",
			use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
			sunlight_propagates = true,
			selection_box = selectionbox,
			node_box = nodebox,
			walkable = false,
			drop = "mesecons:wire_00000000_off",
			is_ground_content = false,
			mesecon_wire = true
		},{
			description = desc_off,
			inventory_image = img,
			wield_image = img,
			tiles = tiles_off,
			mesecons = meseconspec_off,
		},{
			tiles = tiles_on,
			mesecons = meseconspec_on,
		})

		-- Add Help entry aliases for e.g. making it identifiable by the lookup tool [doc_identifier]
		if minetest.get_modpath("doc") then
			if nodeid ~= "00000000" then
				doc.add_entry_alias("nodes", "mesecons:wire_00000000_off", "nodes", "mesecons:wire_"..nodeid.."_off")
			end
			doc.add_entry_alias("nodes", "mesecons:wire_00000000_off", "nodes", "mesecons:wire_"..nodeid.."_on")
		end

		if (nid_inc(nid) == false) then return end
	end
end
register_wires()

minetest.register_alias("mesecons:redstone", "mesecons:wire_00000000_off")
