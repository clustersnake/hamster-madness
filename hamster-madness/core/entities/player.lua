-- core/entities/player.lua
local states = require "core.constants.states"
local metrics = require "core.constants.metrics"

local M = {}

function M.create()
	return {
		state = states.PLAYER_PROTECTED,
		speed = metrics.PLAYER_SPEED,
		-- Usamos tablas simples para que sea Lua puro si prefieres, 
		-- o asumimos que el script pasará vectores de Defold.
		direction = { x = 0, y = 0 }, 
		facing_direction = { x = 1, y = 0 }
	}
end

function M.calculate_movement(self, input_x, input_y, dt)
	-- Verificación manual de componentes para evitar nil en vmath
	if input_x ~= 0 or input_y ~= 0 then
		-- Calculamos la magnitud manualmente para normalizar
		local mag = math.sqrt(input_x^2 + input_y^2)
		self.direction.x = input_x / mag
		self.direction.y = input_y / mag

		-- Guardamos la dirección a la que mira el hámster
		self.facing_direction.x = self.direction.x
		self.facing_direction.y = self.direction.y
	else
		self.direction.x = 0
		self.direction.y = 0
	end

	return self.direction.x * self.speed * dt, self.direction.y * self.speed * dt
end

return M