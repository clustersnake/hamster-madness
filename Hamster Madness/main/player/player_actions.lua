-- player_actions.lua
-- Acciones y lógica del jugador

local animation = require "main.player.player_animation"
local base_character = require "main.characters.base_character"

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
-- INICIALIZACIÓN DE PERSONAJE (NUEVO)
-- ============================================================

--- Inicializa el estado del personaje cuando se recibe set_character
function M.init_character(self, character_id, character_data)
	self.character_id = character_id
	self.character_data = character_data

	-- Crear estado de personaje usando base_character
	self.character_state = base_character.create_state(character_data)

	-- Aplicar velocidad inicial
	self.speed = base_character.get_speed(self.character_state)

	-- NUEVO: Configurar animaciones del personaje
	animation.set_character_anims(self, character_data)

	-- Forzar actualización de animación con el nuevo sprite
	animation.update(self, true)

	print("[Player] ═══════════════════════════")
	print("[Player] Personaje: " .. character_data.name)
	print("[Player] Velocidad: " .. self.speed)
	print("[Player] Habilidad: " .. character_data.ability_type)
	print("[Player] ═══════════════════════════")
end

--- Actualiza el estado del personaje (llamar cada frame)
function M.update_character(self, dt)
	if self.character_state then
		base_character.update(self.character_state, dt)
	end
end

-- ============================================================
-- ESCUDO / PROYECTIL
-- ============================================================

function M.set_shield_state(self, has_shield)
	self.has_projectile = has_shield

	-- Actualizar estado del personaje si existe
	if self.character_state then
		self.character_state.has_shield = has_shield

		-- TANK: Resetear aguante cuando recupera escudo
		if self.character_data and self.character_data.ability_type == "shield_endurance" then
			if has_shield then
				local ability_data = require "main.data.ability_data"
				local stats = ability_data.get_ability_stats("shield_endurance", self.character_state.ability_level)
				self.character_state.ability_state.endurance_hits_remaining = stats.extra_hits
				self.character_state.ability_state.is_endurance_active = false
				self.character_state.ability_state.cooldown_timer = 0
				print("[Tank] Escudo recuperado - Aguante reseteado")
			end
		end
	end

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

	-- Actualizar estado del personaje
	if self.character_state then
		self.character_state.is_invulnerable = true
	end

	M.start_invulnerability_flash(self)

	timer.delay(duration or self.invulnerability_time, false, function()
		self.is_invulnerable = false
		if self.character_state then
			self.character_state.is_invulnerable = false
		end

		-- Restaurar tinte normal (blanco)
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
		print("Invulnerabilidad terminada")
	end)
end

function M.take_damage(self, enemy_position)
if self.is_invulnerable then
	return
end

-- NUEVO: Usar el sistema de personaje para procesar daño
local result = "shield_lost"
local message = ""

if self.character_state then
	result, message = base_character.process_damage(self.character_state, self.has_projectile)
	print("[Damage] Resultado: " .. result .. " - " .. message)
else
	-- Fallback si no hay character_state (no debería pasar)
	if self.has_projectile then
		result = "shield_lost"
	else
		result = "died"
	end
end

-- Procesar resultado
if result == "blocked" then
	-- Invulnerable, no hacer nada
	return

elseif result == "shield_hit" then
	-- TANK: Aguantó el golpe, no pierde escudo
	animation.on_damage(self)

	-- Feedback visual especial para Tank
	M.tank_endurance_feedback(self)

	-- Pequeña invulnerabilidad para evitar spam
	M.start_invulnerability(self, 0.5)

elseif result == "dodged" then
	-- LUCKY: Esquivó el golpe
	print("¡Esquivó!")

	-- Feedback visual de esquiva
	M.dodge_feedback(self)

elseif result == "shield_lost" then
	-- Comportamiento normal: pierde escudo
	print("¡Escudo destruido!")
	animation.on_damage(self)

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

elseif result == "died" then
	-- Muerte
	print("¡Jugador eliminado!")
	animation.on_damage(self)

	self.is_alive = false
	msg.post(".", "release_input_focus")
	msg.post("/game_manager", "player_died", { 
		position = go.get_position(),
		character_id = self.character_id
	})
	msg.post("/tutorial_floor", "show_rescue")
end
end

-- ============================================================
-- FEEDBACK VISUAL (NUEVO)
-- ============================================================

--- Feedback visual cuando Tank aguanta un golpe
function M.tank_endurance_feedback(self)
	-- Flash verde para indicar que aguantó
	sprite.set_constant("#sprite", "tint", vmath.vector4(0.5, 1, 0.5, 1))

	timer.delay(0.1, false, function()
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end)

	-- Mostrar mensaje en HUD
	if self.character_state then
		local remaining = self.character_state.ability_state.endurance_hits_remaining
		msg.post("/hud#hud", "show_message", { 
			text = "¡AGUANTE! (" .. remaining .. ")", 
			duration = 0.5 
		})
	end
end

--- Feedback visual cuando Lucky esquiva
function M.dodge_feedback(self)
	-- Flash amarillo para indicar esquiva
	sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 0.5, 1))

	timer.delay(0.15, false, function()
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end)

	msg.post("/hud#hud", "show_message", { 
		text = "¡ESQUIVA!", 
		duration = 0.5 
	})
end

-- ============================================================
-- EXPERIENCIA (NUEVO)
-- ============================================================

--- Agrega experiencia al personaje actual
function M.add_exp(self, amount)
if not self.character_state then
	return false
end

local leveled_up = base_character.add_exp(self.character_state, amount)

if leveled_up then
	-- Actualizar velocidad si es Speedy
	if self.character_data.ability_type == "speed_boost" then
		self.speed = base_character.get_speed(self.character_state)
		print("[Speedy] Nueva velocidad: " .. self.speed)
	end

	-- Notificar al HUD
	msg.post("/hud#hud", "level_up", {
		character_name = self.character_data.name,
		new_level = self.character_state.ability_level
	})
end

-- Actualizar barra de EXP
msg.post("/hud#hud", "update_exp", {
	progress = base_character.get_exp_progress(self.character_state),
	level = self.character_state.ability_level
})

return leveled_up
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
	-- Usar velocidad del personaje
	local speed = self.speed
	if self.character_state then
		speed = base_character.get_speed(self.character_state)
	end

	movement = movement + vmath.normalize(self.direction) * speed * dt
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