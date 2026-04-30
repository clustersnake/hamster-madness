-- base_character.lua
-- Clase base con comportamiento compartido entre todos los personajes

local ability_data = require "main.data.ability_data"

local M = {}

-- ═══════════════════════════════════════════════════════════════
-- CREACIÓN DEL ESTADO BASE
-- ═══════════════════════════════════════════════════════════════

--- Crea el estado inicial de un personaje
-- @param character_data Datos del personaje desde character_data.lua
-- @return Estado inicial del personaje
function M.create_state(character_data)
	local state = {
		-- Identificación
		character_id = character_data.id,
		character_data = character_data,

		-- Progresión
		ability_level = 1,
		current_exp = 0,

		-- Estado de escudo (compartido)
		has_shield = false,

		-- Invulnerabilidad
		is_invulnerable = false,

		-- Estado específico según tipo de personaje
		ability_state = {}
	}

	-- Inicializar estado específico de habilidad
	M.init_ability_state(state, character_data)

	return state
end

--- Inicializa el estado específico de la habilidad del personaje
function M.init_ability_state(state, character_data)
	local ability_type = character_data.ability_type

	if ability_type == "shield_endurance" then
		-- TANK: Sistema de aguante
		local stats = ability_data.get_ability_stats("shield_endurance", state.ability_level)
		state.ability_state = {
			endurance_hits_remaining = stats.extra_hits,
			endurance_cooldown = stats.cooldown,
			cooldown_timer = 0,
			is_endurance_active = false,  -- true cuando recibió golpe y está en cooldown
		}

	elseif ability_type == "speed_boost" then
		-- SPEEDY: Multiplicador de velocidad
		local stats = ability_data.get_ability_stats("speed_boost", state.ability_level)
		state.ability_state = {
			speed_multiplier = stats.speed_multiplier,
		}

	elseif ability_type == "luck" then
		-- LUCKY: Probabilidades
		local stats = ability_data.get_ability_stats("luck", state.ability_level)
		state.ability_state = {
			crit_chance = stats.crit_chance,
			crit_multiplier = stats.crit_multiplier,
			dodge_chance = stats.dodge_chance,
		}

	elseif ability_type == "dash" then
		-- DASHER: Cargas de dash
		local stats = ability_data.get_ability_stats("dash", state.ability_level)
		state.ability_state = {
			max_charges = stats.charges,
			current_charges = stats.charges,
			cooldown = stats.cooldown,
			cooldown_timer = 0,
			distance = stats.distance,
			i_frames = stats.i_frames,
			is_dashing = false,
		}

	elseif ability_type == "mine" then
		-- TRAPPER: Configuración de mina
		local stats = ability_data.get_ability_stats("mine", state.ability_level)
		state.ability_state = {
			damage_multiplier = stats.damage_multiplier,
			radius = stats.radius,
			duration = stats.duration,
			mine_active = false,
		}

	elseif ability_type == "redirect" then
		-- TRICKSHOT: Redirecciones
		local stats = ability_data.get_ability_stats("redirect", state.ability_level)
		state.ability_state = {
			max_redirects = stats.redirects,
			redirects_remaining = stats.redirects,
			aim_assist = stats.aim_assist,
		}
	end
end

-- ═══════════════════════════════════════════════════════════════
-- ACTUALIZACIÓN
-- ═══════════════════════════════════════════════════════════════

--- Actualiza el estado del personaje (llamar cada frame)
function M.update(state, dt)
	local ability_type = state.character_data.ability_type

	-- TANK: Actualizar cooldown de aguante
	if ability_type == "shield_endurance" then
		if state.ability_state.is_endurance_active then
			state.ability_state.cooldown_timer = state.ability_state.cooldown_timer - dt

			if state.ability_state.cooldown_timer <= 0 then
				-- Cooldown terminó: resetear aguante
				local stats = ability_data.get_ability_stats("shield_endurance", state.ability_level)
				state.ability_state.endurance_hits_remaining = stats.extra_hits
				state.ability_state.is_endurance_active = false
				print("[Tank] Aguante reseteado!")
			end
		end

		-- DASHER: Recargar cargas de dash
	elseif ability_type == "dash" then
		if state.ability_state.current_charges < state.ability_state.max_charges then
			state.ability_state.cooldown_timer = state.ability_state.cooldown_timer - dt

			if state.ability_state.cooldown_timer <= 0 then
				state.ability_state.current_charges = state.ability_state.current_charges + 1
				state.ability_state.cooldown_timer = state.ability_state.cooldown
				print("[Dasher] Carga recuperada: " .. state.ability_state.current_charges)
			end
		end
	end
end

-- ═══════════════════════════════════════════════════════════════
-- SISTEMA DE DAÑO
-- ═══════════════════════════════════════════════════════════════

--- Resultado del procesamiento de daño
-- @return "blocked" | "shield_hit" | "shield_lost" | "dodged" | "died"
function M.process_damage(state, has_shield)
	-- Si es invulnerable, bloquear
	if state.is_invulnerable then
		return "blocked", "Invulnerable"
	end

	local ability_type = state.character_data.ability_type

	-- ═══════════════════════════════════════════════════════════
	-- TANK: Sistema de aguante
	-- ═══════════════════════════════════════════════════════════
	if ability_type == "shield_endurance" and has_shield then
		if state.ability_state.endurance_hits_remaining > 0 then
			-- Tiene aguante: absorbe el golpe sin perder escudo
			state.ability_state.endurance_hits_remaining = state.ability_state.endurance_hits_remaining - 1
			state.ability_state.is_endurance_active = true
			state.ability_state.cooldown_timer = state.ability_state.endurance_cooldown

			print("[Tank] ¡Aguante! Golpes restantes: " .. state.ability_state.endurance_hits_remaining)
			return "shield_hit", "Tank aguantó el golpe"
		else
			-- Sin aguante: pierde escudo normalmente
			print("[Tank] Sin aguante - pierde escudo")
			return "shield_lost", "Escudo destruido"
		end
	end

	-- ═══════════════════════════════════════════════════════════
	-- LUCKY: Probabilidad de esquivar
	-- ═══════════════════════════════════════════════════════════
	if ability_type == "luck" and not has_shield then
		local roll = math.random()
		if roll < state.ability_state.dodge_chance then
			print("[Lucky] ¡Esquivó! (roll: " .. string.format("%.2f", roll) .. " < " .. state.ability_state.dodge_chance .. ")")
			return "dodged", "Lucky esquivó el golpe"
		end
	end

	-- ═══════════════════════════════════════════════════════════
	-- COMPORTAMIENTO NORMAL
	-- ═══════════════════════════════════════════════════════════
	if has_shield then
		return "shield_lost", "Escudo destruido"
	else
		return "died", "Sin escudo"
	end
end

-- ═══════════════════════════════════════════════════════════════
-- VELOCIDAD
-- ═══════════════════════════════════════════════════════════════

--- Obtiene la velocidad final del personaje (base * multiplicador)
function M.get_speed(state)
	local base_speed = state.character_data.base_speed

	if state.character_data.ability_type == "speed_boost" then
		return base_speed * state.ability_state.speed_multiplier
	end

	return base_speed
end

-- ═══════════════════════════════════════════════════════════════
-- PROGRESIÓN
-- ═══════════════════════════════════════════════════════════════

--- Agrega experiencia y verifica si sube de nivel
-- @return true si subió de nivel
function M.add_exp(state, amount)
	if state.ability_level >= ability_data.max_level then
		return false  -- Ya está al máximo
	end

	state.current_exp = state.current_exp + amount

	if ability_data.should_level_up(state.ability_level, state.current_exp) then
		state.ability_level = state.ability_level + 1
		print("[" .. state.character_data.name .. "] ¡Subió a nivel " .. state.ability_level .. "!")

		-- Reinicializar estado de habilidad con nuevos stats
		M.init_ability_state(state, state.character_data)

		return true
	end

	return false
end

--- Obtiene el progreso de EXP actual (0.0 - 1.0)
function M.get_exp_progress(state)
	if state.ability_level >= ability_data.max_level then
		return 1.0
	end

	local current = state.current_exp
	local prev_level_exp = ability_data.exp_requirements[state.ability_level] or 0
	local next_level_exp = ability_data.exp_requirements[state.ability_level + 1]

	local exp_in_level = current - prev_level_exp
	local exp_needed = next_level_exp - prev_level_exp

	return exp_in_level / exp_needed
end

return M