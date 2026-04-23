-- enemy_common.lua
-- Lógica compartida entre todos los tipos de enemigos

local M = {}

-- ============================================================
-- INICIALIZACIÓN
-- ============================================================

function M.init_state(self)
	self.player_id = nil
	self.direction = vmath.vector3(0, 0, 0)
	self.correction = vmath.vector3(0, 0, 0)
	self.is_alive = true
	self.is_paused = false
end

function M.request_target(self)
	timer.delay(0.1, false, function()
		msg.post("/wave_manager", "get_player_target", { requester = go.get_id() })
	end)
end

-- ============================================================
-- ESTADO
-- ============================================================

function M.can_act(self)
	return self.is_alive and not self.is_paused
end

function M.pause(self)
	self.is_paused = true
	print("[Enemy] Pausado")
end

function M.resume(self)
	self.is_paused = false
	print("[Enemy] Reanudado")
end

-- ============================================================
-- DAÑO Y MUERTE
-- ============================================================

function M.die(self)
	if not self.is_alive then
		return
	end

	self.is_alive = false
	print("¡Enemigo eliminado!")
	msg.post("/wave_manager", "enemy_died")
	go.delete()
end

function M.damage_player(self, player_id)
	local my_pos = go.get_position()
	msg.post(player_id, "enemy_damage", { enemy_position = my_pos })
	print("¡Enemigo tocó al jugador!")
end

-- ============================================================
-- MOVIMIENTO
-- ============================================================

function M.apply_correction(self, message)
	if message.distance > 0 then
		self.correction = self.correction + message.normal * message.distance
	end
end

function M.reset_correction(self)
	self.correction = vmath.vector3(0, 0, 0)
end

function M.has_valid_target(self)
	return self.player_id and go.exists(self.player_id)
end

function M.clear_target(self)
	self.player_id = nil
	print("[Enemy] Target perdido...")
end

function M.set_target(self, player_id)
	self.player_id = player_id
	print("[Enemy] Target actualizado: " .. tostring(player_id))
end

-- ============================================================
-- REBOTE EN PAREDES
-- ============================================================

-- Calcula la dirección reflejada al chocar con una pared
-- @param direction: vector3 - dirección actual del movimiento
-- @param normal: vector3 - normal de la superficie de colisión
-- @return vector3 - nueva dirección reflejada y normalizada
function M.reflect_direction(direction, normal)
	-- Fórmula de reflexión: R = D - 2(D·N)N
	local dot = vmath.dot(direction, normal)
	local reflected = direction - 2 * dot * normal
	return vmath.normalize(reflected)
end

-- Maneja el rebote completo con contador opcional
-- @param self: instancia del enemigo
-- @param normal: vector3 - normal de la colisión
-- @param options: table (opcional)
--   - direction_field: string - nombre del campo de dirección (default: "direction")
--   - bounce_field: string - nombre del contador de rebotes (default: nil, no cuenta)
--   - max_bounces: number - máximo de rebotes antes de callback (default: nil, infinito)
--   - on_max_bounces: function(self) - callback al alcanzar máximo
-- @return boolean - true si el rebote fue procesado
function M.handle_wall_bounce(self, normal, options)
	options = options or {}

	local dir_field = options.direction_field or "direction"
	local bounce_field = options.bounce_field
	local max_bounces = options.max_bounces
	local on_max_bounces = options.on_max_bounces

	-- Obtener dirección actual
	local current_dir = self[dir_field]
	if not current_dir or vmath.length(current_dir) == 0 then
		return false
	end

	-- Calcular nueva dirección
	self[dir_field] = M.reflect_direction(current_dir, normal)

	-- Manejar contador de rebotes si está configurado
	if bounce_field then
		self[bounce_field] = (self[bounce_field] or 0) + 1
		print("[Enemy] Rebote #" .. self[bounce_field])

		-- Verificar máximo de rebotes
		if max_bounces and self[bounce_field] >= max_bounces then
			if on_max_bounces then
				on_max_bounces(self)
			end
		end
	end

	return true
end

-- ============================================================
-- HANDLER DE MENSAJES COMUNES
-- ============================================================

-- Retorna true si el mensaje fue manejado
function M.handle_message(self, message_id, message, sender)
	if message_id == hash("take_damage") then

		-- Cuando el enemigo muere, enviar EXP al player
		msg.post("/game_manager", "enemy_killed", { enemy_type = "common" })
		M.die(self)
		return true
	end

	if message_id == hash("pause") then
		M.pause(self)
		return true
	end

	if message_id == hash("resume") then
		M.resume(self)
		return true
	end

	if message_id == hash("set_target") then
		M.set_target(self, message.player_id)
		return true
	end

	return false
end

-- Retorna true si la colisión fue manejada
function M.handle_collision(self, message)
	if message.group == hash("default") then
		M.apply_correction(self, message)
		return true
	end

	if message.group == hash("player") then
		M.damage_player(self, message.other_id)
		return true
	end

	return false
end

-- ============================================================
-- LÍMITES DE SALA (BOUNDS)
-- ============================================================

-- Aplica límites lógicos y rebota si es necesario
-- Útil cuando no hay paredes físicas o para garantizar contención
-- @param self: instancia del enemigo
-- @param position: vector3 - posición a validar
-- @param options: table
--   - bounds: table {left, right, top, bottom}
--   - direction_field: string (default: "direction")
--   - bounce_field: string (opcional)
--   - max_bounces: number (opcional)
--   - on_bounce: function(self) (opcional)
--   - on_max_bounces: function(self) (opcional)
-- @return vector3, boolean - posición corregida, hubo rebote
function M.apply_bounds(self, position, options)
	local bounds = options.bounds
	local dir_field = options.direction_field or "direction"
	local dir = self[dir_field]
	local new_pos = vmath.vector3(position)
	local bounced = false

	-- Rebote horizontal
	if new_pos.x <= bounds.left then
		new_pos.x = bounds.left
		dir.x = math.abs(dir.x)
		bounced = true
	elseif new_pos.x >= bounds.right then
		new_pos.x = bounds.right
		dir.x = -math.abs(dir.x)
		bounced = true
	end

	-- Rebote vertical
	if new_pos.y <= bounds.bottom then
		new_pos.y = bounds.bottom
		dir.y = math.abs(dir.y)
		bounced = true
	elseif new_pos.y >= bounds.top then
		new_pos.y = bounds.top
		dir.y = -math.abs(dir.y)
		bounced = true
	end

	if bounced then
		self[dir_field] = vmath.normalize(dir)

		-- Contador de rebotes
		if options.bounce_field then
			self[options.bounce_field] = (self[options.bounce_field] or 0) + 1
			print("[Enemy] Rebote #" .. self[options.bounce_field])

			if options.on_bounce then
				options.on_bounce(self)
			end

			if options.max_bounces and self[options.bounce_field] >= options.max_bounces then
				if options.on_max_bounces then
					options.on_max_bounces(self)
				end
			end
		end
	end

	return new_pos, bounced
end

return M