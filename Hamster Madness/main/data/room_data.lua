-- room_data.lua
-- Datos de las habitaciones: spawn points, metadata, etc.

local M = {}

-- Configuración global
M.config = {
	min_distance_from_player = 150,
	spawn_margin = 32,

	-- Tamaño de la pantalla (para cálculos de cámara)
	screen_width = 1280,
	screen_height = 720,
	hud_height = 80,
	game_height = 640,  -- 720 - 80
}

-- Función helper para calcular bounds de cámara automáticamente
local function calculate_camera_bounds(room_width, room_height)
	local half_screen_w = M.config.screen_width / 2
	local half_game_h = M.config.game_height / 2
	local hud = M.config.hud_height

	return {
		left = half_screen_w,
		right = math.max(half_screen_w, room_width - half_screen_w),
		bottom = hud + half_game_h,
		top = math.max(hud + half_game_h, room_height + hud - half_game_h)
	}
end

-- ============================================
-- SALA DE PRUEBA (tamaño = pantalla)
-- ============================================
M.test_room = {
	name = "Test Room",

	-- Tamaño de la sala
	size = {
		width = 1280,
		height = 640
	},

	-- ¿La sala es más grande que la pantalla?
	scrollable = false,

	-- Bounds de cámara (calculados automáticamente abajo)
	camera_bounds = nil,

	-- Centro de la cámara (para salas fijas)
	camera_center = {
		x = 640,
		y = 360  -- 80 (HUD) + 640/2
	},

	-- Área jugable (dentro de las paredes)
	playable = {
		min_x = 64,
		max_x = 1216,
		min_y = 144,
		max_y = 656
	},

	-- Spawns
	player_spawn = {x = 640, y = 250},
	ball_spawn = {x = 640, y = 400},

	-- Spawn points de enemigos
	spawn_points = {
		-- Fila superior (y = 600)
		{x = 150,  y = 600},
		{x = 420,  y = 600},
		{x = 640,  y = 600},
		{x = 860,  y = 600},
		{x = 1130, y = 600},

		-- Fila media-alta (y = 500)
		{x = 250,  y = 500},
		{x = 550,  y = 500},
		{x = 730,  y = 500},
		{x = 1030, y = 500},

		-- Fila central (y = 400)
		{x = 150,  y = 400},
		{x = 450,  y = 400},
		{x = 830,  y = 400},
		{x = 1130, y = 400},

		-- Fila media-baja (y = 300)
		{x = 300,  y = 300},
		{x = 640,  y = 300},
		{x = 980,  y = 300},
	}
}

-- Calcular bounds para test_room
M.test_room.camera_bounds = calculate_camera_bounds(
M.test_room.size.width,
M.test_room.size.height
)

-- ============================================
-- EJEMPLO: SALA GRANDE (2x ancho de pantalla)
-- Descomenta cuando la necesites
-- ============================================
--[[
M.big_room = {
name = "Big Room",

size = {
	width = 2560,   -- 2x pantalla
	height = 640
},

scrollable = true,  -- Cámara sigue al jugador

camera_bounds = nil,  -- Se calcula abajo

camera_center = nil,  -- No aplica para salas scrollable

playable = {
	min_x = 64,
	max_x = 2496,   -- 2560 - 64
	min_y = 144,
	max_y = 656
},

player_spawn = {x = 300, y = 250},
ball_spawn = {x = 640, y = 400},

spawn_points = {
	-- Zona izquierda
	{x = 200,  y = 600},
	{x = 500,  y = 500},
	{x = 300,  y = 400},

	-- Zona central
	{x = 1000, y = 600},
	{x = 1280, y = 500},
	{x = 1500, y = 400},

	-- Zona derecha
	{x = 2000, y = 600},
	{x = 2200, y = 500},
	{x = 2400, y = 400},
}
}

M.big_room.camera_bounds = calculate_camera_bounds(
M.big_room.size.width,
M.big_room.size.height
)
--]]

-- ============================================
-- HUB (Sala central con puertas)
-- ============================================
M.hub_room = {
	name = "Hub",

	type = "hub",

	size = {
		width = 1280,
		height = 640
	},

	scrollable = false,

	camera_bounds = nil,

	camera_center = {
		x = 640,
		y = 360
	},

	playable = {
		min_x = 64,
		max_x = 1216,
		min_y = 144,
		max_y = 656
	},

	doors = {
		north = { x = 640, y = 112, state = "locked", target_room = nil },
		south = { x = 640, y = 688, state = "locked", target_room = nil },
		west  = { x = 32,  y = 400, state = "locked", target_room = nil },
		east  = { x = 1248, y = 400, state = "locked", target_room = nil },
	},

	player_spawn = { x = 640, y = 250 },
	ball_spawn = { x = 640, y = 400 },

	spawn_points = {
		{x = 640, y = 250},  -- Centro, cerca del player_spawn
		{x = 250, y = 400},
		{x = 1030, y = 400},
		{x = 450, y = 550},
		{x = 830, y = 550},
	},
}

M.hub_room.camera_bounds = calculate_camera_bounds(
	M.hub_room.size.width,
	M.hub_room.size.height
)

-- ============================================
-- SALA ACTUAL (se actualiza dinámicamente)
-- ============================================
M.current = M.test_room

return M