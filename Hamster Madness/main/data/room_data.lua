-- room_data.lua
-- Datos de las habitaciones: spawn points, metadata, etc.

local M = {}

-- Configuración global de spawn
M.config = {
	min_distance_from_player = 120,  -- Distancia mínima del jugador
	spawn_margin = 16,               -- Margen extra de paredes
}

-- Room de prueba actual
M.test_room = {
	name = "Test Room",
	bounds = {
		min_x = 48,
		max_x = 432,
		min_y = 48,
		max_y = 592
	},
	player_spawn = {x = 240, y = 150},

	ball_spawn = {x = 240, y = 350},

	-- 12 spawn points distribuidos estratégicamente
	spawn_points = {
		-- Fila superior (lejos del spawn del jugador)
		{x = 80,  y = 520},
		{x = 240, y = 520},
		{x = 400, y = 520},

		-- Fila media-alta
		{x = 120, y = 420},
		{x = 360, y = 420},

		-- Fila central
		{x = 80,  y = 320},
		{x = 400, y = 320},

		-- Fila media-baja
		{x = 120, y = 220},
		{x = 360, y = 220},

		-- Fila inferior (cerca del jugador - se filtrarán si está cerca)
		{x = 80,  y = 120},
		{x = 240, y = 280},
		{x = 400, y = 120},
	}
}

-- Alias para la room actual (cambiar cuando implementes más rooms)
M.current = M.test_room

return M