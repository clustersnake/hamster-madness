-- turtle_states.lua
-- Máquina de estados para el boss tortuga
local camera = require "orthographic.camera"

local room_data = require "main.data.room_data"

local M = {}

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

local function get_room_bounds(margin)
	margin = margin or 0
	local p = room_data.current.playable
	return {
		left = p.min_x + margin,
		right = p.max_x - margin,
		bottom = p.min_y + margin,
		top = p.max_y - margin
	}
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
	-- No actualizar si está pausado
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
		-- Parpadeo visual de advertencia
		self.flash_timer = self.flash_timer + dt
		if self.flash_timer >= 0.12 then
			self.flash_timer = 0
			self.flash_on = not self.flash_on
			local tint = self.flash_on 
			and vmath.vector4(1, 1, 0.3, 1)  -- Amarillo brillante
			or vmath.vector4(1, 1, 1, 1)     -- Normal
			sprite.set_constant("#sprite", "tint", tint)
		end

		-- Ejecutar ataque especial después de cargar
		if self.state_timer >= self.charge_duration then
			sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))

			if self.current_phase == 1 then
				M.change_state(self, M.STATE.MEGA_APLASTON)
			else
				M.change_state(self, M.STATE.RODADA)
			end
		end
	end,

	exit = function(self)
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end
}

-- ============================================================
-- ESTADO: CHASE (Persiguiendo al jugador)
-- ============================================================

M.states[M.STATE.CHASE] = {
	enter = function(self)
		-- Nada especial
	end,

	update = function(self, dt)
		local distance = get_distance_to_player(self)

		-- ¿Llegó a rango de ataque?
		if distance <= self.aplaston_range then
			M.change_state(self, M.STATE.APLASTON)
			return
		end

		-- Mover hacia el jugador
		local dir = get_direction_to_player(self)
		local pos = go.get_position()
		pos = pos + dir * self.walk_speed * dt
		go.set_position(pos)

		-- Timeout: evitar persecución infinita
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
		-- TODO: Animación de levantar caparazón
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
-- ============================================================

M.states[M.STATE.RODADA] = {
	enter = function(self)
		print("[Turtle] ¡¡RODADA!!")

		self.rodada_bounces = 0
		self.max_bounces = 5 + math.random(3)  -- 5-8 rebotes
		self.last_bounce_time = 0  -- Para evitar doble conteo en esquinas

		-- Dirección inicial hacia el jugador
		self.rodada_direction = get_direction_to_player(self)

		-- Obtener límites de la sala con margen para el tamaño de la tortuga
		self.room_bounds = get_room_bounds(50)

		print("[Turtle] Rebotes objetivo: " .. self.max_bounces)

		-- TODO: Cambiar a sprite de caparazón rodando
		-- sprite.play_flipbook("#sprite", "turtle_shell")
		-- ═══════════════════════════════════════
		-- JUICE: GIRO VISUAL (NUEVO)
		-- ═══════════════════════════════════════
		-- Hacemos que rote 360 grados infinitamente cada 0.4 segundos
		go.animate(".", "euler.z", go.PLAYBACK_LOOP_FORWARD, 360, go.EASING_LINEAR, 0.4)

		self.rodada_bounces = 0
		self.max_bounces = 5 + math.random(3)
		self.last_bounce_time = 0

		self.rodada_direction = get_direction_to_player(self)
		self.room_bounds = get_room_bounds(50)
	end,

	update = function(self, dt)
		local pos = go.get_position()
		local new_pos = pos + self.rodada_direction * self.rodada_speed * dt

		-- Detectar rebotes (con protección contra doble conteo)
		local bounced = false
		local min_bounce_interval = 0.1  -- Mínimo tiempo entre rebotes

		-- Rebote horizontal
		if new_pos.x <= self.room_bounds.left then
			new_pos.x = self.room_bounds.left
			self.rodada_direction.x = math.abs(self.rodada_direction.x)
			bounced = true
		elseif new_pos.x >= self.room_bounds.right then
			new_pos.x = self.room_bounds.right
			self.rodada_direction.x = -math.abs(self.rodada_direction.x)
			bounced = true
		end

		-- Rebote vertical
		if new_pos.y <= self.room_bounds.bottom then
			new_pos.y = self.room_bounds.bottom
			self.rodada_direction.y = math.abs(self.rodada_direction.y)
			bounced = true
		elseif new_pos.y >= self.room_bounds.top then
			new_pos.y = self.room_bounds.top
			self.rodada_direction.y = -math.abs(self.rodada_direction.y)
			bounced = true
		end

		-- Contar rebote (evitando doble conteo en esquinas)
		if bounced and (self.state_timer - self.last_bounce_time) > min_bounce_interval then
			self.rodada_bounces = self.rodada_bounces + 1
			self.last_bounce_time = self.state_timer

			print("[Turtle] Rebote #" .. self.rodada_bounces .. "/" .. self.max_bounces)

			-- Variación aleatoria del ángulo para impredecibilidad
			local variation = (math.random() - 0.5) * 0.4
			local angle = math.atan2(self.rodada_direction.y, self.rodada_direction.x) + variation
			self.rodada_direction.x = math.cos(angle)
			self.rodada_direction.y = math.sin(angle)
			self.rodada_direction = vmath.normalize(self.rodada_direction)
		end

		go.set_position(new_pos)

		-- ¿Terminó la rodada?
		if self.rodada_bounces >= self.max_bounces then
			print("[Turtle] Rodada completada")
			M.change_state(self, M.STATE.IDLE)
			return
		end

		-- Timeout de seguridad
		if self.state_timer >= 12.0 then
			print("[Turtle] Rodada timeout")
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self)
		-- Resetear cooldown del especial
		self.special_cooldown = self.special_cooldown_max

		-- TODO: Volver a sprite normal
		-- sprite.play_flipbook("#sprite", "turtle_idle")
		go.cancel_animations(".", "euler.z")
		go.set_rotation(vmath.quat()) -- Vuelve a su orientación original

		self.special_cooldown = self.special_cooldown_max
	end
}

-- ============================================================
-- ESTADO: PARRY (Reflejando proyectiles, Fase 3)
-- ============================================================

M.states[M.STATE.PARRY] = {
	enter = function(self)
		print("[Turtle] ¡PARRY ACTIVO!")
		self.is_parrying = true

		-- Feedback visual: tinte defensivo
		sprite.set_constant("#sprite", "tint", vmath.vector4(0.7, 0.7, 1, 1))

		-- TODO: Animación defensiva
		-- sprite.play_flipbook("#sprite", "turtle_shell")
	end,

	update = function(self, dt)
		-- Parpadeo sutil mientras está en parry
		local pulse = 0.7 + math.sin(self.state_timer * 8) * 0.15
		sprite.set_constant("#sprite", "tint", vmath.vector4(pulse, pulse, 1, 1))

		if self.state_timer >= self.parry_duration then
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self)
		self.is_parrying = false
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
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

		-- Feedback visual: tinte de vulnerabilidad
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 0.8, 0.8, 1))

		-- TODO: Animación panza arriba
		-- sprite.play_flipbook("#sprite", "turtle_belly")
	end,

	update = function(self, dt)
		-- Parpadeo de advertencia cuando queda poco tiempo
		local time_left = self.vulnerable_duration - self.state_timer

		if time_left <= 1.5 then
			-- Parpadeo cada vez más rápido
			local freq = 4 + (1.5 - time_left) * 8
			local flash = math.floor(self.state_timer * freq) % 2 == 0
			local alpha = flash and 1.0 or 0.4
			sprite.set_constant("#sprite", "tint", vmath.vector4(1, 0.8, 0.8, alpha))
		end

		if self.state_timer >= self.vulnerable_duration then
			print("[Turtle] Se recuperó sin recibir daño")
			M.change_state(self, M.STATE.IDLE)
		end
	end,

	exit = function(self)
		self.can_be_damaged = false
		self.special_cooldown = self.special_cooldown_max
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))

		-- TODO: Volver a sprite normal
		-- sprite.play_flipbook("#sprite", "turtle_idle")
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

		-- Feedback visual
		sprite.set_constant("#sprite", "tint", vmath.vector4(0.5, 0.5, 0.5, 1))

		-- Notificar al game manager
		msg.post("/game_manager", "boss_defeated")

		-- TODO: Animación de muerte

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

	-- ¿Cooldown del ataque especial listo?
	if self.special_cooldown <= 0 then
		print("[Turtle] ¡Ataque especial listo!")
		M.change_state(self, M.STATE.CHARGING)
		return
	end

	-- FASE 1: Solo aplastones normales (esperando mega)
	if phase == 1 then
		M.change_state(self, M.STATE.CHASE)
		return
	end

	-- FASE 2: Aplastones + Rodada (cuando cooldown listo)
	if phase == 2 then
		M.change_state(self, M.STATE.CHASE)
		return
	end

	-- FASE 3: Todo + Parry aleatorio entre ataques
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
	print("[Turtle] ¡APLASTÓN! Radio: " .. radius)

	local my_pos = go.get_position()
	local player_pos = get_player_position(self)

	-- ═══════════════════════════════════════
	-- SCREEN SHAKE
	-- ═══════════════════════════════════════
	local camera_id = go.get_id("/camera")
	camera.shake(camera_id, 0.003, 0.3, hash("both"))

	if player_pos then
		local distance = vmath.length(player_pos - my_pos)

		if distance <= radius then
			print("[Turtle] ¡Jugador en rango!")
			msg.post(self.player_id, "enemy_damage", {
				damage = 1,
				enemy_position = my_pos
			})
		else
			print("[Turtle] Jugador fuera de rango (" .. math.floor(distance) .. " > " .. radius .. ")")
		end
	end
	-- TODO: Crear efecto visual de onda expansiva
	-- factory.create("#shockwave_factory", my_pos)
end

function M.do_mega_aplaston(self)
	print("[Turtle] ¡¡MEGA APLASTÓN!! (Pantalla completa)")

	-- ═══════════════════════════════════════
	-- SCREEN SHAKE GRANDE
	-- ═══════════════════════════════════════
	local camera_id = go.get_id("/camera")
	camera.shake(camera_id, 0.006, 0.5, hash("both"))

	if self.player_id and go.exists(self.player_id) then
		msg.post(self.player_id, "enemy_damage", {
			damage = 1,
			enemy_position = go.get_position()
		})
	end
	-- TODO: Efecto visual de pantalla completa
end

-- ============================================================
-- MANEJO DE IMPACTOS
-- ============================================================

function M.on_hit_by_projectile(self)
	-- Durante RODADA: la voltea
	if self.current_state == M.STATE.RODADA then
		print("[Turtle] ¡Impacto durante rodada! → VULNERABLE")
		M.change_state(self, M.STATE.VULNERABLE)
		return "flipped"
	end

	-- Durante PARRY: refleja el proyectil
	if self.current_state == M.STATE.PARRY or self.is_parrying then
		print("[Turtle] ¡PARRY! Reflejando proyectil...")
		return "parry"
	end

	-- Durante VULNERABLE: recibe daño
	if self.can_be_damaged then
		return "damage"
	end

	-- Cualquier otro estado: inmune
	print("[Turtle] Inmune al daño en estado: " .. tostring(self.current_state))
	return "immune"
end

-- Función legacy para compatibilidad (ya no se usa activamente)
function M.on_hit_wall(self, normal)
	-- Los rebotes ahora se manejan manualmente en RODADA.update
	-- Esta función queda por si se necesita para algo más
end
-- ============================================================
-- FEEDBACK DE DAÑO
-- ============================================================

function M.on_damage_taken(self)
	local camera_id = go.get_id("/camera")

	-- Screen shake de impacto
	camera.shake(camera_id, 0.004, 0.25, hash("both"))

	-- Flash blanco → rojo → normal
	go.cancel_animations("#sprite", "tint")

	-- Blanco instantáneo
	sprite.set_constant("#sprite", "tint", vmath.vector4(10, 10, 10, 1))

	-- Rojo después de un frame
	timer.delay(0.05, false, function()
		if not go.exists(go.get_id()) then return end
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 0.2, 0.2, 1))
	end)

	-- Volver a normal
	timer.delay(0.15, false, function()
		if not go.exists(go.get_id()) then return end
		sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
	end)

	-- Squash & stretch (aplastamiento)
	local sprite_url = msg.url(nil, go.get_id(), "sprite")

	-- Squash
	go.set_scale(vmath.vector3(1.3, 0.7, 1))

	-- Volver a normal con bounce
	go.animate(".", "scale", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1, 1, 1), go.EASING_OUTBOUNCE, 0.3)

	print("[Turtle] ¡OUCH!")
end

return M