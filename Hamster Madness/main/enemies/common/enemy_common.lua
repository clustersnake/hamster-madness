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
-- HANDLER DE MENSAJES COMUNES
-- ============================================================

-- Retorna true si el mensaje fue manejado
function M.handle_message(self, message_id, message, sender)
	if message_id == hash("take_damage") then
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

return M