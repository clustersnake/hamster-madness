-- abilities.lua
-- Estado global de habilidades y rasgos del personaje (composición).
-- Cada habilidad/rasgo es una entrada en su tabla; se activan por nombre.

local M = {}

-- Habilidades globales desbloqueables (por progresión, ej. derrotar al armadillo)
M.global = {
	bounce = false, -- rebote en paredes
}

-- Rasgos del personaje activo (definidos por personaje, ej. Trickshot)
M.character = {
	ricochet = false, -- rebote entre enemigos (solo Trickshot)
}

function M.unlock(name)
	M.global[name] = true
end

function M.is_unlocked(name)
	return M.global[name] == true
end

function M.has_trait(name)
	return M.character[name] == true
end

function M.debug_toggle_global(name)
	M.global[name] = not (M.global[name] == true)
end

function M.debug_toggle_trait(name)
	M.character[name] = not (M.character[name] == true)
end

return M