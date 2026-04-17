-- shooter_behavior.lua
-- Comportamiento específico del Shooter: mantener distancia y disparar

local common = require "main.shared.entity_common"

local M = {}

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

M.MIN_DISTANCE = 80
M.MAX_DISTANCE = 150
M.SHOOT_COOLDOWN = 2.0
M.PROJECTILE_OFFSET = 15  -- Distancia desde el centro al spawnear bala

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

	-- Determinar dirección hacia el jugador
	if distance > 0 then
		self.direction = vmath.normalize(to_player)
	end

	-- Lógica de movimiento según distancia
	local movement = vmath.vector3(0)

	if distance < M.MIN_DISTANCE then
		movement = -self.direction * self.speed * dt
	elseif distance > M.MAX_DISTANCE then
		movement = self.direction * self.speed * 0.5 * dt
	end

	go.set_position(my_pos + movement + self.correction)

	M.update_facing(self, to_player)
	M.update_shooting(self, dt, distance)

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
-- DISPARO
-- ============================================================

function M.update_shooting(self, dt, distance)
	-- Cooldown
	if not self.can_shoot then
		self.shoot_timer = self.shoot_timer - dt
		if self.shoot_timer <= 0 then
			self.can_shoot = true
		end
	end

	-- Disparar si está en rango y puede
	local in_range = distance <= M.MAX_DISTANCE and distance >= M.MIN_DISTANCE * 0.5

	if self.can_shoot and in_range and common.has_valid_target(self) then
		M.fire_projectile(self)
		self.can_shoot = false
		self.shoot_timer = M.SHOOT_COOLDOWN
	end
end

function M.fire_projectile(self)
	local my_pos = go.get_position()

	-- Posición de spawn (un poco adelante del enemigo)
	local spawn_pos = my_pos + self.direction * M.PROJECTILE_OFFSET

	-- Crear proyectil
	local projectile_id = factory.create("#projectile_factory", spawn_pos)

	if projectile_id then
		-- Enviar dirección al proyectil
		msg.post(projectile_id, "set_direction", { direction = self.direction })
		print("[Shooter] Disparo!")
	end
end

return M