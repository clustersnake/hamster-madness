-- chaser_behavior.lua
-- Comportamiento específico del Chaser: perseguir al jugador constantemente

local common = require "main.enemies.common.enemy_common"

local M = {}

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

M.MIN_DISTANCE = 10  -- Distancia mínima para moverse

-- ============================================================
-- MOVIMIENTO
-- ============================================================

function M.update(self, dt)
	if not common.can_act(self) then
		return
	end

	if not common.has_valid_target(self) then
		common.clear_target(self)
		return
	end

	local my_pos = go.get_position()
	local player_pos = go.get_position(self.player_id)
	local to_player = player_pos - my_pos

	if vmath.length(to_player) > M.MIN_DISTANCE then
		self.direction = vmath.normalize(to_player)
		local movement = self.direction * self.speed * dt
		go.set_position(my_pos + movement + self.correction)
	end

	common.reset_correction(self)
end

return M