-- game_config.lua
-- Configuración global del juego

local M = {}

-- ═══════════════════════════════════════════════════════════════
-- MODO DE JUEGO
-- ═══════════════════════════════════════════════════════════════

M.is_demo = true  -- Cambiar a false para versión completa

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE PERSONAJES
-- ═══════════════════════════════════════════════════════════════

M.max_characters = M.is_demo and 2 or 6

-- ═══════════════════════════════════════════════════════════════
-- TIEMPOS Y DURACIONES
-- ═══════════════════════════════════════════════════════════════

M.rescue_time = 3.0               -- Segundos para completar rescate
M.invulnerability_time = 1.5      -- I-frames después de perder escudo
M.death_transition_time = 3.0     -- Countdown antes de spawn del siguiente personaje
M.tank_endurance_cooldown = 3.0   -- Cooldown del aguante de Tank

-- ═══════════════════════════════════════════════════════════════
-- PROYECTIL/ESCUDO
-- ═══════════════════════════════════════════════════════════════

M.projectile = {
	base_speed = 400,
	max_distance = 500,
	knockback_distance = 200,  -- Distancia cuando sale por daño
	base_damage = 1,
	critical_multiplier = 2.0,
}

-- ═══════════════════════════════════════════════════════════════
-- ACCIONES DE INPUT (para referencia)
-- ═══════════════════════════════════════════════════════════════

M.actions = {
	move_up = "move_up",
	move_down = "move_down",
	move_left = "move_left",
	move_right = "move_right",
	shoot = "shoot",
	rescue = "rescue",
	-- Futuras
	dash = "dash",
	parry = "parry",
	recall = "recall",      -- Telaraña
	plant_mine = "plant_mine",  -- Trapper
}

return M