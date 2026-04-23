-- character_data.lua
-- Definición de todos los personajes del juego

local M = {}

-- ═══════════════════════════════════════════════════════════════
-- DATOS DE PERSONAJES
-- ═══════════════════════════════════════════════════════════════

M.characters = {
	tank = {
		id = "tank",
		name = "Tank",
		description = "Resiste un golpe adicional con escudo",

		base_speed = 250,
		ability_type = "shield_endurance",

		damage_config = {
			type = "endurance",
			endurance_hits = 1,
			endurance_cooldown = 3.0,
		},

		-- ACTUALIZADO: Animaciones con prefijo
		animations = {
			idle_down = "tank_idle_down",
			idle_up = "tank_idle_up",
			idle_right = "tank_idle_right",
			walk_down = "tank_walk_down",
			walk_up = "tank_walk_up",
			walk_right = "tank_walk_right",
			fallen = "tank_fallen",
		},
	},

	speedy = {
		id = "speedy",
		name = "Speedy",
		description = "Se mueve más rápido que los demás",

		base_speed = 350,
		ability_type = "speed_boost",

		damage_config = {
			type = "normal",
		},

		-- ACTUALIZADO: Animaciones con prefijo
		animations = {
			idle_down = "speedy_idle_down",
			idle_up = "speedy_idle_up",
			idle_right = "speedy_idle_right",
			walk_down = "speedy_walk_down",
			walk_up = "speedy_walk_up",
			walk_right = "speedy_walk_right",
			fallen = "speedy_fallen",
		},
	},

	-- ═══════════════════════════════════════════════════════════════
	-- PERSONAJES FUTUROS (estructura lista)
	-- ═══════════════════════════════════════════════════════════════

	lucky = {
		id = "lucky",
		name = "Lucky",
		description = "Probabilidad de crítico y esquivar golpes",
		base_speed = 280,
		ability_type = "luck",
		damage_config = {
			type = "luck",
			dodge_chance = 0.05,  -- 5% base de esquivar
		},
		animations = {},
		tint = vmath.vector4(1, 1, 0.6, 1),  -- Amarillento
	},

	dasher = {
		id = "dasher",
		name = "Dasher",
		description = "Puede hacer dash con invencibilidad",
		base_speed = 300,
		ability_type = "dash",
		damage_config = { type = "normal" },
		animations = {},
		tint = vmath.vector4(0.6, 0.8, 1, 1),  -- Azulado
	},

	trapper = {
		id = "trapper",
		name = "Trapper",
		description = "Convierte el disparo en mina",
		base_speed = 280,
		ability_type = "mine",
		damage_config = { type = "normal" },
		animations = {},
		tint = vmath.vector4(0.8, 0.6, 1, 1),  -- Morado
	},

	trickshot = {
		id = "trickshot",
		name = "Trickshot",
		description = "Redirige el proyectil tras impactar",
		base_speed = 280,
		ability_type = "redirect",
		damage_config = { type = "normal" },
		animations = {},
		tint = vmath.vector4(1, 0.8, 0.6, 1),  -- Naranja
	},
}

-- ═══════════════════════════════════════════════════════════════
-- CONFIGURACIÓN DE POOLS
-- ═══════════════════════════════════════════════════════════════

-- Demo: solo 2 personajes
M.demo_roster = {"tank", "speedy"}

-- Juego completo: todos
M.full_roster = {"tank", "speedy", "lucky", "dasher", "trapper", "trickshot"}

-- ═══════════════════════════════════════════════════════════════
-- FUNCIONES HELPER
-- ═══════════════════════════════════════════════════════════════

--- Obtiene datos de un personaje por ID
function M.get(character_id)
	return M.characters[character_id]
end

--- Obtiene el roster actual (demo o completo)
function M.get_roster(is_demo)
	if is_demo then
		return M.demo_roster
	end
	return M.full_roster
end

--- Mezcla aleatoriamente un array (Fisher-Yates shuffle)
function M.shuffle_roster(roster)
	local shuffled = {}
	for i, v in ipairs(roster) do
		shuffled[i] = v
	end

	for i = #shuffled, 2, -1 do
		local j = math.random(1, i)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end

	return shuffled
end

--- Crea una cola de personajes aleatoria
function M.create_character_queue(is_demo)
	local roster = M.get_roster(is_demo)
	return M.shuffle_roster(roster)
end

return M