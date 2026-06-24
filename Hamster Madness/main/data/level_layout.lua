local M = {}

M.templates = {
	room_small  = "/main/rooms/templates/room_small.collection",
	room_medium = "/main/rooms/templates/room_medium.collection",
	room_large  = "/main/rooms/templates/room_large.collection",
	room_boss   = "/main/rooms/templates/room_boss.collection",
}

M.door_positions = {
	north = { x = 640, y = 688 },
	south = { x = 640, y = 112 },
	west  = { x = 32,  y = 400 },
	east  = { x = 1248, y = 400 },
}

M.opposite_door = {
	north = "south",
	south = "north",
	east  = "west",
	west  = "east",
}

M.door_offsets = {
	north = { x = 0,   y = -48 },
	south = { x = 0,   y = 48 },
	west  = { x = 48,  y = 0 },
	east  = { x = -48, y = 0 },
}

M.WAVE_CONFIG = {
	[1] = { enemies = 3, spawn_delay = 0.6,  shooter_chance = 0.0 },
	[2] = { enemies = 5, spawn_delay = 0.5,  shooter_chance = 0.2 },
	[3] = { enemies = 7, spawn_delay = 0.4,  shooter_chance = 0.35 },
	[4] = { enemies = 9, spawn_delay = 0.35, shooter_chance = 0.45 },
	[5] = { enemies = 12, spawn_delay = 0.3, shooter_chance = 0.5 },
}

local ROOM_BASE = {
	scrollable = false,
	camera_center = { x = 640, y = 360 },
	camera_bounds = {
		left   = 640,
		right  = 640,
		bottom = 400,
		top    = 400,
	},
	playable = {
		min_x = 64,
		max_x = 1216,
		min_y = 144,
		max_y = 656,
	},
	player_spawn = { x = 640, y = 250 },
	ball_spawn   = { x = 640, y = 400 },
}

local function merge_room(data)
	for k, v in pairs(ROOM_BASE) do
		if data[k] == nil then
			data[k] = v
		end
	end
	return data
end

M.rooms = {
	hub = merge_room {
		type = "hub",
		template = "room_small",
		doors = {
			north = "sala_combate_1",
			east  = "sala_combate_2",
			south = "sala_tesoro",
		},
		difficulty = 0,
		is_boss = false,
	},

	sala_combate_1 = merge_room {
		type = "combat",
		template = "room_small",
		doors = {
			south = "hub",
		},
		difficulty = 2,
		is_boss = false,
	},

	sala_combate_2 = merge_room {
		type = "combat",
		template = "room_small",
		doors = {
			west = "hub",
		},
		difficulty = 3,
		is_boss = true,
	},

	sala_tesoro = merge_room {
		type = "treasure",
		template = "room_small",
		doors = {
			north = "hub",
		},
		difficulty = 0,
		is_boss = false,
	},
}

function M.init()
	M.current_room_id = nil
	M.room_states = {}
	M.enemies_defeated = 0

	for id, room in pairs(M.rooms) do
		M.room_states[id] = {
			cleared = false,
			visited = false,
			boss_defeated = false,
		}
		-- Non-combat rooms start cleared
		if room.difficulty == 0 then
			M.room_states[id].cleared = true
		end
	end

	-- Hub starts visited too
	M.room_states.hub.visited = true

	print("[LevelLayout] Inicializado con " .. #M.get_room_ids() .. " salas")
end

function M.get_room(room_id)
	return M.rooms[room_id]
end

function M.get_room_ids()
	local ids = {}
	for id, _ in pairs(M.rooms) do
		table.insert(ids, id)
	end
	return ids
end

function M.get_state(room_id)
	return M.room_states[room_id]
end

function M.get_current_room()
	return M.rooms[M.current_room_id]
end

function M.get_wave_config(difficulty)
	difficulty = math.max(1, math.min(difficulty, 5))
	return M.WAVE_CONFIG[difficulty]
end

function M.get_wave_count(difficulty)
	local config = M.get_wave_config(difficulty)
	local count = 0
	for i, _ in ipairs(M.WAVE_CONFIG) do
		if i <= difficulty then
			count = count + 1
		end
	end
	return math.max(1, math.floor(difficulty / 2) + 1)
end

return M
