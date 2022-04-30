minetest.register_entity(":__builtin:item", {
	initial_properties = {
		hp_max = 1,
		physical = true,
		collide_with_objects = false,
		collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
		pointable = false,
		visual = "wielditem",
		visual_size = {x = 0.4, y = 0.4},
		textures = {""},
		spritediv = {x = 1, y = 1},
		initial_sprite_basepos = {x = 0, y = 0},
		is_visible = false,
		infotext = "",
	},

	-- Itemstring of dropped item. The empty string is used when the item is not yet initialized yet.
	-- The itemstring MUST be set immediately to a non-empty string after creating the entity.
	-- The hand is NOT permitted as dropped item. ;-)
	-- Item entities will be deleted if they still have an empty itemstring on their first on_step tick.
	itemstring = "",

	-- Number of seconds this item entity has existed so far
	age = 0,

	-- How old it has become in the collection animation
	collection_age = 0,

	set_item = function(self, itemstring)
		self.itemstring = itemstring
		if self.itemstring == "" then
			-- item not yet known
			return
		end
		local stack = ItemStack(itemstring)
		local count = stack:get_count()
		local max_count = stack:get_stack_max()
		if count > max_count then
			count = max_count
			self.itemstring = stack:get_name().." "..max_count
		end
		local itemtable = stack:to_table()
		local itemname = nil
		local description = ""
		if itemtable then
			itemname = stack:to_table().name
		end
		local glow
		local def = minetest.registered_items[itemname]
		if def then
			description = def.description
			glow = def.light_source
		end
		local s = 0.2 + 0.1 * (count / max_count)
		local wield_scale = (def and def.wield_scale and def.wield_scale.x) or 1
		local c = s
		s = s / wield_scale
		local prop = {
			is_visible = true,
			visual = "wielditem",
			textures = {itemname},
			visual_size = {x = s, y = s},
			collisionbox = {-c, -c, -c, c, c, c},
			automatic_rotate = math.pi * 0.5,
			infotext = description,
			glow = glow,
		}
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		local data = minetest.serialize({
			itemstring = self.itemstring,
			always_collect = self.always_collect,
			age = self.age,
			_insta_collect = self._insta_collect,
			_flowing = self._flowing,
			_removed = self._removed,
		})
		-- sfan5 guessed that the biggest serializable item
		-- entity would have a size of 65530 bytes. This has
		-- been experimentally verified to be still too large.
		--
		-- anon5 has calculated that the biggest serializable
		-- item entity has a size of exactly 65487 bytes:
		--
		-- 1. serializeString16 can handle max. 65535 bytes.
		-- 2. The following engine metadata is always saved:
		--    • 1 byte (version)
		--    • 2 byte (length prefix)
		--    • 14 byte “__builtin:item”
		--    • 4 byte (length prefix)
		--    • 2 byte (health)
		--    • 3 × 4 byte = 12 byte (position)
		--    • 4 byte (yaw)
		--    • 1 byte (version 2)
		--    • 2 × 4 byte = 8 byte (pitch and roll)
		-- 3. This leaves 65487 bytes for the serialization.
		if #data > 65487 then -- would crash the engine
			local stack = ItemStack(self.itemstring)
			stack:get_meta():from_table(nil)
			self.itemstring = stack:to_string()
			minetest.log(
				"warning",
				"Overlong item entity metadata removed: “" ..
				self.itemstring ..
				"” had serialized length of " ..
				#data
			)
			return self:get_staticdata()
		end
		return data
	end,

	on_activate = function(self, staticdata, dtime_s)
		self.object:set_velocity({x = 0, y = 0, z = 0})
		self.object:set_acceleration({x = 0, y = 0, z = 0})
		self:set_item(self.itemstring)
	end,
})
