-- shooter_behavior.lua
-- Comportamiento específico del Shooter: mantener distancia y disparar

local common = require "main.enemies.common.enemy_common"

local M = {}

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

M.MIN_DISTANCE = 80   -- Muy cerca: retroceder
M.MAX_DISTANCE = 150  -- Muy lejos: acercarse

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
	local distance = vmath.length(to_player)

	-- Determinar dirección de movimiento
	if distance > 0 then
		self.direction = vmath.normalize(to_player)
	end

	-- Lógica de movimiento según distancia
	local movement = vmath.vector3(0)

	if distance < M.MIN_DISTANCE then
		-- Muy cerca: alejarse
		movement = -self.direction * self.speed * dt
	elseif distance > M.MAX_DISTANCE then
		-- Muy lejos: acercarse lentamente
		movement = self.direction * self.speed * 0.5 * dt
	end
	-- Si está en rango ideal: no se mueve

	-- Aplicar movimiento
	go.set_position(my_pos + movement + self.correction)

	-- Actualizar facing (voltear sprite)
	M.update_facing(self, to_player)

	-- Actualizar disparo (por ahora solo timer)
	M.update_shooting(self, dt)

	common.reset_correction(self)
end

-- ============================================================
-- FACING
-- ============================================================

function M.update_facing(self, to_player)
	if to_player.x ~= 0 then
		local facing_left = to_player.x < 0
		sprite.set_hflip("#sprite", facing_left)
	end
end

-- ============================================================
-- DISPARO (placeholder por ahora)
-- ============================================================

function M.update_shooting(self, dt)
	if not self.can_shoot then
		self.shoot_timer = self.shoot_timer - dt
		if self.shoot_timer <= 0 then
			self.can_shoot = true
		end
	end

	-- Por ahora solo imprime cuando "dispararía"
	if self.can_shoot and common.has_valid_target(self) then
		-- print("Shooter: ¡Dispararía ahora!")
		self.can_shoot = false
		self.shoot_timer = self.shoot_cooldown
	end
end

return M