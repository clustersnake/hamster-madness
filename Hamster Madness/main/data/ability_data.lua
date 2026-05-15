-- ability_data.lua
-- Escalado de habilidades por nivel

local M = {}

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN GENERAL
-- ═══════════════════════════════════════════════════════════════

M.max_level = 4

-- EXP requerida para cada nivel
M.exp_requirements = {
	[1] = 0, -- Nivel inicial
	[2] = 100,
	[3] = 250,
	[4] = 500, -- MAX
}

-- EXP que da cada tipo de enemigo
M.exp_rewards = {
	common = 10,
	elite = 25,
	mini_boss = 50,
	boss = 100,
}

-- ═══════════════════════════════════════════════════════════════
-- HABILIDADES DE PERSONAJE (se pierden al morir)
-- ═══════════════════════════════════════════════════════════════

M.character_abilities = {

	-- SPEEDY: Multiplicador de velocidad adicional
	speed_boost = {
		[1] = { speed_multiplier = 1.0 }, -- Base (ya es rápido)
		[2] = { speed_multiplier = 1.15 }, -- +15%
		[3] = { speed_multiplier = 1.30 }, -- +30%
		[4] = { speed_multiplier = 1.50 }, -- +50% MAX
	},

	-- TANK: Aguante del escudo
	shield_endurance = {
		[1] = { extra_hits = 1, cooldown = 3.0 }, -- 1 golpe extra, 3s cooldown
		[2] = { extra_hits = 1, cooldown = 2.5 }, -- Cooldown reducido
		[3] = { extra_hits = 2, cooldown = 2.5 }, -- 2 golpes extra
		[4] = { extra_hits = 2, cooldown = 2.0 }, -- MAX
	},

	-- LUCKY: Probabilidades
	luck = {
		[1] = { crit_chance = 0.10, crit_multiplier = 2.0, dodge_chance = 0.05 },
		[2] = { crit_chance = 0.15, crit_multiplier = 2.0, dodge_chance = 0.10 },
		[3] = { crit_chance = 0.20, crit_multiplier = 2.5, dodge_chance = 0.15 },
		[4] = { crit_chance = 0.30, crit_multiplier = 3.0, dodge_chance = 0.20 }, -- MAX
	},

	-- DASHER: Dash con i-frames
	dash = {
		[1] = { charges = 1, cooldown = 2.0, distance = 100, i_frames = 0.2 },
		[2] = { charges = 2, cooldown = 2.0, distance = 100, i_frames = 0.25 },
		[3] = { charges = 2, cooldown = 1.5, distance = 120, i_frames = 0.25 },
		[4] = { charges = 3, cooldown = 1.5, distance = 150, i_frames = 0.3 }, -- MAX
	},

	-- TRAPPER: Mina
	mine = {
		[1] = { damage_multiplier = 1.0, radius = 50, duration = 5.0 },
		[2] = { damage_multiplier = 1.25, radius = 60, duration = 6.0 },
		[3] = { damage_multiplier = 1.5, radius = 75, duration = 7.0 },
		[4] = { damage_multiplier = 2.0, radius = 100, duration = 10.0 }, -- MAX
	},

	-- TRICKSHOT: Redirecciones
	redirect = {
		[1] = { redirects = 1, aim_assist = 0.0 },
		[2] = { redirects = 2, aim_assist = 0.1 },
		[3] = { redirects = 3, aim_assist = 0.2 },
		[4] = { redirects = 4, aim_assist = 0.3 }, -- MAX
	},
}

-- ═══════════════════════════════════════════════════════════════
-- HABILIDADES DE BOSS (compartidas, NO se pierden al morir)
-- ═══════════════════════════════════════════════════════════════

M.boss_abilities = {

	-- PARRY: Deflectar proyectiles enemigos
	parry = {
		unlocked_by = "spider_boss",
		[0] = { unlocked = false },
		[1] = { window = 0.2, cooldown = 1.0 },
		[2] = { window = 0.3, cooldown = 0.8 },
		[3] = { window = 0.4, cooldown = 0.6 },
		[4] = { window = 0.5, cooldown = 0.4, counter_damage = true }, -- MAX
	},

	-- PÚAS: Escudo/proyectil con daño de contacto
	spikes = {
		unlocked_by = "hedgehog_boss",
		[0] = { unlocked = false },
		[1] = { contact_damage = 1, duration = 2.0 },
		[2] = { contact_damage = 1, duration = 3.0 },
		[3] = { contact_damage = 2, duration = 3.0 },
		[4] = { contact_damage = 2, duration = 5.0, reflects_projectiles = true }, -- MAX
	},

	-- TELARAÑA: Recuperar proyectil a distancia
	web_recall = {
		unlocked_by = "spider_boss",
		[0] = { unlocked = false },
		[1] = { recall_speed = 200, cooldown = 5.0 },
		[2] = { recall_speed = 300, cooldown = 4.0 },
		[3] = { recall_speed = 400, cooldown = 3.0 },
		[4] = { recall_speed = 500, cooldown = 2.0, damages_enemies = true }, -- MAX
	},
}

-- ═══════════════════════════════════════════════════════════════
-- FUNCIONES HELPER
-- ═══════════════════════════════════════════════════════════════

--- Obtiene los stats de una habilidad de personaje en un nivel específico
function M.get_ability_stats(ability_type, level)
	local ability = M.character_abilities[ability_type]
	if not ability then
		return nil
	end

	level = math.max(1, math.min(level, M.max_level))
	return ability[level]
end

--- Obtiene los stats de una habilidad de boss en un nivel específico
function M.get_boss_ability_stats(ability_type, level)
	local ability = M.boss_abilities[ability_type]
	if not ability then
		return nil
	end

	level = math.max(0, math.min(level, M.max_level))
	return ability[level]
end

--- Calcula la EXP necesaria para el siguiente nivel
function M.get_exp_for_next_level(current_level)
	if current_level >= M.max_level then
		return nil -- Ya está al máximo
	end
	return M.exp_requirements[current_level + 1]
end

--- Verifica si debería subir de nivel
function M.should_level_up(current_level, current_exp)
	local next_level_exp = M.get_exp_for_next_level(current_level)
	if not next_level_exp then
		return false
	end
	return current_exp >= next_level_exp
end

return M
