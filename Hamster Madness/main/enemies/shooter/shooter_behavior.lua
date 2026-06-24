-- shooter_behavior.lua
-- Comportamiento del Shooter: mantener distancia, disparar, 8 direcciones

local common = require "main.shared.entity_common"

local M = {}

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

M.MIN_DISTANCE = 80
M.MAX_DISTANCE = 150
M.SHOOT_COOLDOWN = 2.0
M.PROJECTILE_OFFSET = 15

-- ============================================================
-- DIRECCIÓN (8 direcciones)
-- ============================================================

-- function M.update_direction_sprite(self, to_player)
-- 	local angle = math.atan2(to_player.y, to_player.x)
-- 	local adjusted_angle = angle + (math.pi / 4)
-- 
-- 	local direction_map = {
-- 		"e",  -- 0°
-- 		"ne", -- 45°
-- 		"n",  -- 90°
-- 		"nw", -- 135°
-- 		"w",  -- 180°
-- 		"sw", -- 225°
-- 		"s",  -- 270°
-- 		"se"  -- 315°
-- 	}
-- 
-- 	local index = math.floor((adjusted_angle / (math.pi / 4)) % 8) + 1
-- 	local new_direction = direction_map[index]
-- 
-- 	if new_direction ~= self.current_direction then
-- 		self.current_direction = new_direction
-- 		local sprite_name = "shooter-" .. new_direction
-- 		sprite.play_flipbook("#sprite", hash(sprite_name))
-- 	end
-- end

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

	if distance > 0 then
		self.direction = vmath.normalize(to_player)
	end

	local movement = vmath.vector3(0)

	if distance < M.MIN_DISTANCE then
		movement = -self.direction * self.speed * dt
	elseif distance > M.MAX_DISTANCE then
		movement = self.direction * self.speed * 0.5 * dt
	end

	go.set_position(my_pos + movement + self.correction)

	common.update_direction_sprite(self, "shooter", to_player)
	M.update_shooting(self, dt, distance)

	common.reset_correction(self)
end

-- ============================================================
-- DISPARO
-- ============================================================

function M.update_shooting(self, dt, distance)
	if not self.can_shoot then
		self.shoot_timer = self.shoot_timer - dt
		if self.shoot_timer <= 0 then
			self.can_shoot = true
		end
	end

	local in_range = distance <= M.MAX_DISTANCE and distance >= M.MIN_DISTANCE * 0.5

	if self.can_shoot and in_range and common.has_valid_target(self) then
		M.fire_projectile(self)
		self.can_shoot = false
		self.shoot_timer = M.SHOOT_COOLDOWN
	end
end

function M.fire_projectile(self)
	local my_pos = go.get_position()
	local spawn_pos = my_pos + self.direction * M.PROJECTILE_OFFSET

	local projectile_id = factory.create("#projectile_factory", spawn_pos)

	if projectile_id then
		msg.post(projectile_id, "set_direction", { direction = self.direction })
	end
end

return M
