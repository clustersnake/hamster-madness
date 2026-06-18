-- turtle_states.lua
-- Máquina de estados para el boss tortuga

local camera = require "main.camera.camera"
local room_data = require "main.data.room_data"

local M = {}

local spawn_shockwave -- NUEVO

-- ============================================================
-- CONFIGURACIÓN DE ATAQUES / VFX
-- ============================================================

local ATTACK_CONFIG = {
	aplaston = {
		damage_delay = 0.5, -- Daño medio segundo después del impacto visual
		radius_multiplier = 1.5, -- Aumenta el radio efectivo del aplastón pequeño
		shake_intensity = 0.003,
		shake_duration = 0.3,

		shockwave = {
			max_scale = 4.0, -- Más grande que antes
			duration = 0.3,
			delay = 0,
			start_scale = 0.3,
			color = vmath.vector4(1, 0.6, 0.2, 0.9)
		}
	},

	mega_aplaston = {
		damage_delay = 0.5,
		shake_intensity = 0.006,
		shake_duration = 0.5,

		shockwaves = {
			{
				max_scale = 3.5,
				duration = 0.2,
				delay = 0,
				start_scale = 0.3,
				color = vmath.vector4(1, 0.3, 0.1, 1)
			},
			{
				max_scale = 7.0,
				duration = 0.35,
				delay = 0.08,
				start_scale = 0.3,
				color = vmath.vector4(1, 0.5, 0.2, 0.8)
			},
			{
				max_scale = 12.0,
				duration = 0.5,
				delay = 0.16,
				start_scale = 0.3,
				color = vmath.vector4(1, 0.7, 0.3, 0.5)
			}
		}
	}
}


-- ============================================================
-- ESTADOS
-- ============================================================

M.STATE = {
	INTRO = "intro",
	IDLE = "idle",
	CHASE = "chase",
	APLASTON = "aplaston",
	MEGA_APLASTON = "mega_aplaston",
	CHARGING = "charging",
	RODADA = "rodada",
	PARRY = "parry",
	VULNERABLE = "vulnerable",
	DEAD = "dead"
}

M.states = {}

-- ============================================================
-- HELPERS
-- ============================================================

local function get_player_position(self)
	if self.player_id and go.exists(self.player_id) then
		return go.get_position(self.player_id)
	end
	return nil
end

local function get_distance_to_player(self)
	local player_pos = get_player_position(self)
	if player_pos then
		local my_pos = go.get_position()
		return vmath.length(player_pos - my_pos)
	end
	return 9999
end

local function get_direction_to_player(self)
	local player_pos = get_player_position(self)
	if player_pos then
		local my_pos = go.get_position()
		local dir = player_pos - my_pos
		if vmath.length(dir) > 0 then
			return vmath.normalize(dir)
		end
	end
	return vmath.vector3(0, -1, 0)
end

-- ============================================================
-- CAMBIO DE ESTADO
-- ============================================================

function M.change_state(self, new_state)
	local old_state = self.current_state

	if old_state and M.states[old_state] and M.states[old_state].exit then
		M.states[old_state].exit(self)
	end

	self.current_state = new_state
	self.state_timer = 0

	print("[Turtle] " .. tostring(old_state) .. " → " .. new_state)

	if M.states[new_state] and M.states[new_state].enter then
		M.states[new_state].enter(self)
	end
end

function M.update(self, dt)
	if self.is_paused then
		return
	end

	if self.current_state and M.states[self.current_state] then
		self.state_timer = self.state_timer + dt
		M.states[self.current_state].update(self, dt)
	end
end

-- ============================================================
-- ESTADO: INTRO (Mega Aplastón inicial obligatorio)
-- ============================================================

M.states[M.STATE.INTRO] = {
	enter = function(self)
		print("[Turtle] ═══════════════════════════")
		print("[Turtle]   ¡LA TORTUGA APARECE!     ")
		print("[Turtle] ═══════════════════════════")
		self.intro_phase = "waiting"
	end,

	update = function(self, dt)
		if self.intro_phase == "waiting" and self.state_timer >= 1.5 then
			self.intro_phase = "mega"
			print("[Turtle] ¡¡MEGA APLASTÓN INICIAL!!")
			M.do_mega_aplaston(self)
		end

		if self.intro_phase == "mega" and self.state_timer >= 2.5 then
			M.change_state(self, M.STATE.VULNERABLE)
		end
	end,

	exit = function(self) end
}

-- ============================================================
-- ESTADO: IDLE (Decidiendo qué hacer)
-- ============================================================

M.states[M.STATE.IDLE] = {
	enter = function(self)
		self.idle_duration = 0.8 + math.random() * 0.4
	end,

	update = function(self, dt)
		if self.state_timer >= self.idle_duration then
			M.choose_next_action(self)
		end
	end,

	exit = function(self) end
}

-- ============================================================
-- ESTADO: CHARGING (Brillando antes de ataque especial)
-- ============================================================

M.states[M.STATE.CHARGING] = {
	enter = function(self)
		print("[Turtle] ✨ ¡Cargando ataque especial!")
		self.flash_timer = 0
		self.flash_on = true
	end,

	update = function(self, dt)
		self.flash_timer = self.flash_timer + dt
		if self.flash_timer >= 0.12 then
			self.flash_timer = 0
			self.flash_on = not self.flash_on
			local tint = self.flash_on
				and vmath.vector4(1, 1, 0.3, 1)
				or vmath.vector4(1, 1, 1, 1)
			go.set("#sprite", "tint", tint)
		end

		if self.state_timer >= self.charge_duration then
			go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))

			if self.current_phase == 1 then
				M.change_state(self, M.STATE.MEGA_APLASTON)
			else
				M.change_state(self, M.STATE.RODADA)
			end
		end
	end,

	exit = function(self)
		go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end
}

-- ============================================================
-- ESTADO: CHASE (Persiguiendo al jugador)
-- ============================================================

M.states[M.STATE.CHASE] = {
	enter = function(self) end,

	update = function(self, dt)
		local distance = get_distance_to_player(self)

		if distance <= self.aplaston_range then
			M.change_state(self, M.STATE.APLASTON)
			return
		end

		local dir = get_direction_to_player(self)
		local pos = go.get_position()
		pos = pos + dir * self.walk_speed * dt
		go.set_position(pos)

		if self.state_timer >= 5.0 then
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self) end
}

-- ============================================================
-- ESTADO: APLASTON (Normal, área limitada)
-- ============================================================

M.states[M.STATE.APLASTON] = {
	enter = function(self)
		self.aplaston_phase = "telegraph"
		print("[Turtle] ¡Preparando aplastón!")
	end,

	update = function(self, dt)
		if self.aplaston_phase == "telegraph" then
			if self.state_timer >= self.aplaston_telegraph then
				self.aplaston_phase = "impact"
				M.do_aplaston(self, self.aplaston_radius)
			end
		elseif self.aplaston_phase == "impact" then
			if self.state_timer >= self.aplaston_telegraph + self.aplaston_recovery then
				M.change_state(self, M.STATE.IDLE)
			end
		end
	end,

	exit = function(self) end
}

-- ============================================================
-- ESTADO: MEGA APLASTON (100% pantalla, solo Fase 1)
-- ============================================================

M.states[M.STATE.MEGA_APLASTON] = {
	enter = function(self)
		print("[Turtle] ¡¡MEGA APLASTÓN!!")
		M.do_mega_aplaston(self)
	end,

	update = function(self, dt)
		if self.state_timer >= 1.0 then
			M.change_state(self, M.STATE.VULNERABLE)
		end
	end,

	exit = function(self) end
}

-- ============================================================
-- ESTADO: RODADA (Rebotando por la sala, Fase 2+)
-- Los rebotes se manejan en turtle.script via common.handle_wall_bounce
-- ============================================================

-- M.states[M.STATE.RODADA] = {
-- 	enter = function(self)
-- 		print("[Turtle] ¡¡RODADA!!")
--
-- 		self.rodada_bounces = 0
-- 		self.max_bounces = 5 + math.random(3)
-- 		self.rodada_direction = get_direction_to_player(self)
--
-- 		-- Guardar límites de la sala
-- 		local p = room_data.current.playable
-- 		self.room_bounds = {
-- 			left = p.min_x + 50,
-- 			right = p.max_x - 50,
-- 			bottom = p.min_y + 50,
-- 			top = p.max_y - 50
-- 		}
--
-- 		print("[Turtle] Rebotes objetivo: " .. self.max_bounces)
--
-- 		go.animate(".", "euler.z", go.PLAYBACK_LOOP_FORWARD, 360, go.EASING_LINEAR, 0.4)
-- 	end,
--
-- 	update = function(self, dt)
-- 		local common = require "main.shared.entity_common"
--
-- 		local pos = go.get_position()
-- 		local new_pos = pos + self.rodada_direction * self.rodada_speed * dt
--
-- 		-- Aplicar límites lógicos de la sala
-- 		new_pos, _ = common.apply_bounds(self, new_pos, {
-- 			bounds = self.room_bounds,
-- 			direction_field = "rodada_direction",
-- 			bounce_field = "rodada_bounces",
-- 			max_bounces = self.max_bounces,
-- 			on_bounce = function(boss)
-- 				M.apply_bounce_variation(boss)
-- 			end,
-- 			on_max_bounces = function(boss)
-- 				M.on_rodada_complete(boss)
-- 			end
-- 		})
--
-- 		go.set_position(new_pos)
--
-- 		-- Timeout de seguridad
-- 		if self.state_timer >= 12.0 then
-- 			print("[Turtle] Rodada timeout")
-- 			M.change_state(self, M.STATE.IDLE)
-- 		end
-- 	end,
--
-- 	exit = function(self)
-- 		go.cancel_animations(".", "euler.z")
-- 		go.set_rotation(vmath.quat())
-- 		self.special_cooldown = self.special_cooldown_max
-- 	end
-- }
-- ============================================================
-- ESTADO: RODADA (Rebotando por la sala, Fase 2+)
-- ============================================================

M.states[M.STATE.RODADA] = {
	enter = function(self)
		print("[Turtle] ¡¡RODADA!!")

		self.rodada_bounces = 0
		self.max_bounces = 5 + math.random(3)
		self.rodada_direction = get_direction_to_player(self)

		-- Guardar límites de la sala
		local p = room_data.current.playable
		self.room_bounds = {
			left = p.min_x + 50,
			right = p.max_x - 50,
			bottom = p.min_y + 50,
			top = p.max_y - 50
		}

		print("[Turtle] Rebotes objetivo: " .. self.max_bounces)

		-- NUEVO: Asegurar que el sprite sea visible antes de rodar
		go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))

		-- Animación de rotación
		go.animate(".", "euler.z", go.PLAYBACK_LOOP_FORWARD, 360, go.EASING_LINEAR, 0.4)
	end,

	update = function(self, dt)
		local common = require "main.shared.entity_common"

		local pos = go.get_position()
		local new_pos = pos + self.rodada_direction * self.rodada_speed * dt

		new_pos, _ = common.apply_bounds(self, new_pos, {
			bounds = self.room_bounds,
			direction_field = "rodada_direction",
			bounce_field = "rodada_bounces",
			max_bounces = self.max_bounces,
			on_bounce = function(boss)
				M.apply_bounce_variation(boss)
			end,
			on_max_bounces = function(boss)
				M.on_rodada_complete(boss)
			end
		})

		go.set_position(new_pos)

		if self.state_timer >= 12.0 then
			print("[Turtle] Rodada timeout")
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self)
		-- NUEVO: Cancelar SOLO la animación de rotación
		go.cancel_animations(".", "euler.z")
		go.set_rotation(vmath.quat())

		-- NUEVO: Restaurar visibilidad del sprite
		go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))

		self.special_cooldown = self.special_cooldown_max
	end
}

-- ============================================================
-- CALLBACK: Cuando termina la rodada por máximo de rebotes
-- Llamado desde turtle.script via common.handle_wall_bounce
-- ============================================================

function M.on_rodada_complete(self)
	print("[Turtle] Rodada completada - " .. self.rodada_bounces .. " rebotes")
	M.change_state(self, M.STATE.IDLE)
end

-- ============================================================
-- CALLBACK: Aplicar variación al ángulo después de rebote
-- Llamado desde turtle.script después de common.handle_wall_bounce
-- ============================================================

function M.apply_bounce_variation(self)
	local variation = (math.random() - 0.5) * 0.4
	local angle = math.atan2(self.rodada_direction.y, self.rodada_direction.x) + variation
	self.rodada_direction.x = math.cos(angle)
	self.rodada_direction.y = math.sin(angle)
	self.rodada_direction = vmath.normalize(self.rodada_direction)
end

-- ============================================================
-- ESTADO: PARRY (Reflejando proyectiles, Fase 3)
-- ============================================================

M.states[M.STATE.PARRY] = {
	enter = function(self)
		print("[Turtle] ¡PARRY ACTIVO!")
		self.is_parrying = true
		go.set("#sprite", "tint", vmath.vector4(0.7, 0.7, 1, 1))
	end,

	update = function(self, dt)
		local pulse = 0.7 + math.sin(self.state_timer * 8) * 0.15
		go.set("#sprite", "tint", vmath.vector4(pulse, pulse, 1, 1))

		if self.state_timer >= self.parry_duration then
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self)
		self.is_parrying = false
		go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end
}

-- ============================================================
-- ESTADO: VULNERABLE (Puede recibir daño)
-- ============================================================

M.states[M.STATE.VULNERABLE] = {
	enter = function(self)
		print("[Turtle] ═══════════════════════════")
		print("[Turtle]      ¡¡VULNERABLE!!        ")
		print("[Turtle] ═══════════════════════════")

		self.can_be_damaged = true
		go.set("#sprite", "tint", vmath.vector4(1, 0.8, 0.8, 1))
	end,

	update = function(self, dt)
		local time_left = self.vulnerable_duration - self.state_timer

		if time_left <= 1.5 then
			local freq = 4 + (1.5 - time_left) * 8
			local flash = math.floor(self.state_timer * freq) % 2 == 0
			local alpha = flash and 1.0 or 0.4
			go.set("#sprite", "tint", vmath.vector4(1, 0.8, 0.8, alpha))
		end

		if self.state_timer >= self.vulnerable_duration then
			print("[Turtle] Se recuperó sin recibir daño")
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self)
		self.can_be_damaged = false
		self.special_cooldown = self.special_cooldown_max
		go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end
}

-- ============================================================
-- ESTADO: DEAD
-- ============================================================

M.states[M.STATE.DEAD] = {
	enter = function(self)
		print("[Turtle] ═══════════════════════════")
		print("[Turtle]      ¡¡DERROTADA!!         ")
		print("[Turtle] ═══════════════════════════")

		go.set("#sprite", "tint", vmath.vector4(0.5, 0.5, 0.5, 1))
		msg.post("/game_manager", "boss_defeated")

		timer.delay(2.0, false, function()
			go.delete()
		end)
	end,

	update = function(self, dt) end,
	exit = function(self) end
}

-- ============================================================
-- LÓGICA DE DECISIÓN DE ATAQUES
-- ============================================================

function M.choose_next_action(self)
	local phase = self.current_phase

	if self.special_cooldown <= 0 then
		print("[Turtle] ¡Ataque especial listo!")
		M.change_state(self, M.STATE.CHARGING)
		return
	end

	-- FASE 1: Solo aplastones normales
	if phase == 1 then
		M.change_state(self, M.STATE.CHASE)
		return
	end

	-- FASE 2: Aplastones + Rodada
	if phase == 2 then
		M.change_state(self, M.STATE.CHASE)
		return
	end

	-- FASE 3: Todo + Parry aleatorio
	if phase >= 3 then
		local roll = math.random()
		if roll < 0.30 then
			M.change_state(self, M.STATE.PARRY)
		else
			M.change_state(self, M.STATE.CHASE)
		end
		return
	end
end

-- ============================================================
-- ACCIONES DE ATAQUE
-- ============================================================

function M.do_aplaston(self, radius)
	print("[Turtle] ¡APLASTÓN! Radio base: " .. radius)

	local cfg = ATTACK_CONFIG.aplaston
	local my_pos = go.get_position()

	-- Screen shake
	local camera_id = go.get_id("/camera")
	camera.shake(camera_id, cfg.shake_intensity, cfg.shake_duration, hash("both"))

	-- Shockwave visual
	spawn_shockwave(self, cfg.shockwave)

	-- Daño sincronizado con delay
	timer.delay(cfg.damage_delay, false, function()
		if not go.exists(go.get_id()) then return end
		if not self.player_id or not go.exists(self.player_id) then return end

		local current_player_pos = get_player_position(self)
		if not current_player_pos then return end

		local current_my_pos = go.get_position()
		local distance = vmath.length(current_player_pos - current_my_pos)
		local actual_radius = radius * cfg.radius_multiplier

		if distance <= actual_radius then
			print("[Turtle] ¡Jugador en rango! (" .. math.floor(distance) .. " <= " .. actual_radius .. ")")
			msg.post(self.player_id, "enemy_damage", {
				damage = 1,
				enemy_position = current_my_pos
			})
		else
			print("[Turtle] Jugador fuera de rango (" .. math.floor(distance) .. " > " .. actual_radius .. ")")
		end
	end)
end

function M.do_mega_aplaston(self)
	print("[Turtle] ¡¡MEGA APLASTÓN!! (Pantalla completa)")

	local cfg = ATTACK_CONFIG.mega_aplaston

	local camera_id = go.get_id("/camera")
	camera.shake(camera_id, cfg.shake_intensity, cfg.shake_duration, hash("both"))

	-- Múltiples shockwaves
	for _, wave_cfg in ipairs(cfg.shockwaves) do
		spawn_shockwave(self, wave_cfg)
	end

	-- Daño sincronizado con delay
	timer.delay(cfg.damage_delay, false, function()
		if not go.exists(go.get_id()) then return end
		if not self.player_id or not go.exists(self.player_id) then return end

		msg.post(self.player_id, "enemy_damage", {
			damage = 1,
			enemy_position = go.get_position()
		})
	end)
end

-- ============================================================
-- ACCIONES DE ATAQUE
-- ============================================================

-- function M.do_aplaston(self, radius)
-- 	print("[Turtle] ¡APLASTÓN! Radio: " .. radius)
--
-- 	local my_pos = go.get_position()
-- 	local player_pos = get_player_position(self)
--
-- 	-- Screen shake
-- 	local camera_id = go.get_id("/camera")
-- 	camera.shake(camera_id, 0.003, 0.3, hash("both"))
--
-- 	if player_pos then
-- 		local distance = vmath.length(player_pos - my_pos)
--
-- 		if distance <= radius then
-- 			print("[Turtle] ¡Jugador en rango!")
-- 			msg.post(self.player_id, "enemy_damage", {
-- 				damage = 1,
-- 				enemy_position = my_pos
-- 			})
-- 		else
-- 			print("[Turtle] Jugador fuera de rango (" .. math.floor(distance) .. " > " .. radius .. ")")
-- 		end
-- 	end
-- end
--
-- function M.do_mega_aplaston(self)
-- 	print("[Turtle] ¡¡MEGA APLASTÓN!! (Pantalla completa)")
--
-- 	local camera_id = go.get_id("/camera")
-- 	camera.shake(camera_id, 0.006, 0.5, hash("both"))
--
-- 	if self.player_id and go.exists(self.player_id) then
-- 		msg.post(self.player_id, "enemy_damage", {
-- 			damage = 1,
-- 			enemy_position = go.get_position()
-- 		})
-- 	end
-- end
--
-- ============================================================
-- MANEJO DE IMPACTOS
-- ============================================================

function M.on_hit_by_projectile(self)
	if self.current_state == M.STATE.RODADA then
		print("[Turtle] ¡Impacto durante rodada! → VULNERABLE")
		M.change_state(self, M.STATE.VULNERABLE)
		return "flipped"
	end

	if self.current_state == M.STATE.PARRY or self.is_parrying then
		print("[Turtle] ¡PARRY! Reflejando proyectil...")
		return "parry"
	end

	if self.can_be_damaged then
		return "damage"
	end

	print("[Turtle] Inmune al daño en estado: " .. tostring(self.current_state))
	return "immune"
end

-- ============================================================
-- FEEDBACK DE DAÑO
-- ============================================================

function M.on_damage_taken(self)
	local camera_id = go.get_id("/camera")
	camera.shake(camera_id, 0.004, 0.25, hash("both"))

	go.cancel_animations("#sprite", "tint")

	-- Flash blanco → rojo → normal
	go.set("#sprite", "tint", vmath.vector4(10, 10, 10, 1))

	timer.delay(0.05, false, function()
		if not go.exists(go.get_id()) then return end
		go.set("#sprite", "tint", vmath.vector4(1, 0.2, 0.2, 1))
	end)

	timer.delay(0.15, false, function()
		if not go.exists(go.get_id()) then return end
		go.set("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end)

	-- Squash & stretch
	go.set_scale(vmath.vector3(1.3, 0.7, 1))
	go.animate(".", "scale", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1, 1, 1), go.EASING_OUTBOUNCE, 0.3)

	print("[Turtle] ¡OUCH!")
end

-- ============================================================
-- EFECTOS VISUALES
-- ============================================================

-- ============================================================
-- EFECTOS VISUALES
-- ============================================================

spawn_shockwave = function(self, config)
	timer.delay(config.delay or 0, false, function()
		if not go.exists(go.get_id()) then return end

		local pos = go.get_position()
		pos.z = 0.6

		local props = {
			max_scale = config.max_scale or 3.0,
			duration = config.duration or 0.4,
			start_scale = config.start_scale or 0.3
		}

		local id = factory.create("#shockwave_factory", pos, nil, props)

		if id and config.color then
			msg.post(id, "set_color", { color = config.color })
		end
	end)
end

return M
