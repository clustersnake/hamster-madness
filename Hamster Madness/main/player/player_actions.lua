-- player_actions.lua
-- Acciones y lógica del jugador

local animation = require "main.player.player_animation"

local M = {}

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

M.MOVEMENT_MAP = {
	[hash("move_up")] = vmath.vector3(0, 1, 0),
	[hash("move_down")] = vmath.vector3(0, -1, 0),
	[hash("move_left")] = vmath.vector3(-1, 0, 0),
	[hash("move_right")] = vmath.vector3(1, 0, 0),
}

-- ============================================================
-- ESCUDO / PROYECTIL
-- ============================================================

function M.set_shield_state(self, has_shield)
	self.has_projectile = has_shield
	local alpha = has_shield and 1 or 0
	sprite.set_constant("#shield", "tint", vmath.vector4(1, 1, 1, alpha))
	msg.post("/hud#hud", "update_shield", { has_shield = has_shield })
end

-- ============================================================
-- APUNTADO
-- ============================================================

function M.get_aim_direction(self)
	local player_pos = go.get_position()
	local crosshair_pos = go.get_position("/crosshair")
	local aim_vector = vmath.vector3(
	crosshair_pos.x - player_pos.x,
	crosshair_pos.y - player_pos.y,
	0
)

if vmath.length(aim_vector) > 10 then
	return vmath.normalize(aim_vector)
end
return self.facing
end

-- ============================================================
-- DISPARO
-- ============================================================

function M.fire_projectile(self)
if not self.has_projectile then
	print("No tienes proyectil - ¡recógelo primero!")
	return false
end

local player_pos = go.get_position()
local aim_direction = M.get_aim_direction(self)

local spawn_pos = player_pos + aim_direction * 50
spawn_pos.z = 0.5

local projectile_id = factory.create("#projectile_factory", spawn_pos)
msg.post(projectile_id, "fire", { direction = aim_direction })

M.set_shield_state(self, false)
print("¡Disparo!")
return true
end

-- ============================================================
-- DAÑO E INVULNERABILIDAD
-- ============================================================

function M.start_invulnerability_flash(self)
local flash_duration = 0.15
local num_flashes = math.floor(self.invulnerability_time / (flash_duration * 2))

for i = 0, num_flashes - 1 do
	timer.delay(flash_duration * 2 * i, false, function()
		if self.is_invulnerable then
			sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 0.3))
		end
	end)
	timer.delay(flash_duration * (2 * i + 1), false, function()
		if self.is_invulnerable then
			sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
		end
	end)
end
end

function M.start_invulnerability(self, duration)
self.is_invulnerable = true
M.start_invulnerability_flash(self)

timer.delay(duration or self.invulnerability_time, false, function()
	self.is_invulnerable = false
	sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	print("Invulnerabilidad terminada")
end)
end

function M.take_damage(self, enemy_position)
	if self.is_invulnerable then
		return
	end

	-- Animación de daño (MOVIDO FUERA DEL IF)
	animation.on_damage(self)

	if self.has_projectile then
		print("¡Escudo destruido!")

		local player_pos = go.get_position()
		local knockback_dir = player_pos - enemy_position

		if vmath.length(knockback_dir) > 0 then
			knockback_dir = vmath.normalize(knockback_dir)
		else
			knockback_dir = vmath.vector3(0, 1, 0)
		end

		local spawn_pos = player_pos + knockback_dir * 40
		spawn_pos.z = 0.5
		local shield_id = factory.create("#active_shield_factory", spawn_pos)
		msg.post(shield_id, "fire", { direction = knockback_dir })

		M.set_shield_state(self, false)
		M.start_invulnerability(self)
	else
		print("¡Jugador eliminado!")
		self.is_alive = false
		msg.post(".", "release_input_focus")
		msg.post("/game_manager", "player_died", { position = go.get_position() })
		msg.post("/tutorial_floor", "show_rescue")
	end
end

-- ============================================================
-- RESCATE
-- ============================================================

function M.handle_rescue_input(self, action)
if not (self.near_fallen and self.fallen_id) then
	return
end

if action.pressed then
	print("[Player] Iniciando rescate...")
	self.is_rescuing = true
	msg.post(self.fallen_id, "rescue_hold")
elseif action.released then
	print("[Player] Rescate interrumpido")
	self.is_rescuing = false
	if go.exists(self.fallen_id) then
		msg.post(self.fallen_id, "rescue_release")
	end
end
end

function M.clear_rescue_state(self)
self.near_fallen = false
self.fallen_id = nil
self.is_rescuing = false
end

-- ============================================================
-- MOVIMIENTO
-- ============================================================

function M.apply_movement(self, dt)
local is_moving = vmath.length(self.direction) > 0
local movement = self.correction

if is_moving then
	movement = movement + vmath.normalize(self.direction) * self.speed * dt
end

if vmath.length(movement) > 0 then
	go.set_position(go.get_position() + movement)
end

-- Actualizar facing hacia crosshair
local aim_dir = M.get_aim_direction(self)
if vmath.length(aim_dir) > 0 then
	self.facing = aim_dir
end

return is_moving
end

function M.reset_frame_state(self)
self.direction = vmath.vector3(0, 0, 0)
self.correction = vmath.vector3(0, 0, 0)
end

return M