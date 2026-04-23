-- localization.lua
-- Sistema simple de traducciones

local M = {}

-- Idioma actual
M.current_language = "en"

-- Traducciones
M.strings = {
	en = {
		-- HUD
		next = "NEXT",
		lives = "LIVES",
		wave = "WAVE",
		shield = "SHIELD",
		ready = "READY",
		last = "LAST!",

		-- Modos
		normal = "NORMAL",
		rescue = "RESCUE",
		boss = "BOSS",
		victory = "VICTORY!",

		-- Mensajes
		game_over = "GAME OVER",
		rescue_success = "RESCUE COMPLETE!",
		rescue_prompt = "RESCUE YOUR ALLY!",
		level_up = "LVL",

		-- Personajes
		tank = "Tank",
		speedy = "Speedy",
		lucky = "Lucky",
		dasher = "Dasher",
		trapper = "Trapper",
		trickshot = "Trickshot",

		-- Habilidades
		endurance = "ENDURE!",
		dodge = "DODGE!",
		
		-- Oleadas
		wave_complete = "WAVE COMPLETE!",
		rescue_wave = "RESCUE",
	},

	es = {
		-- HUD
		next = "SIG.",
		lives = "VIDAS",
		wave = "OLEADA",
		shield = "ESCUDO",
		ready = "LISTO",
		last = "¡ÚLTIMO!",

		-- Modos
		normal = "NORMAL",
		rescue = "RESCATE",
		boss = "JEFE",
		victory = "¡VICTORIA!",

		-- Mensajes
		game_over = "FIN DEL JUEGO",
		rescue_success = "¡RESCATE EXITOSO!",
		rescue_prompt = "¡RESCATA A TU COMPAÑERO!",
		level_up = "NVL",

		-- Personajes
		tank = "Tank",
		speedy = "Speedy",
		lucky = "Lucky",
		dasher = "Dasher",
		trapper = "Trapper",
		trickshot = "Trickshot",

		-- Habilidades
		endurance = "¡AGUANTE!",
		dodge = "¡ESQUIVA!",
		
		-- Oleadas
		wave_complete = "¡OLEADA COMPLETADA!",
		rescue_wave = "RESCATE",
	},
}

--- Obtiene un texto traducido
-- @param key Clave del texto
-- @return Texto traducido o la clave si no existe
function M.get(key)
	local lang = M.strings[M.current_language]
	if lang and lang[key] then
		return lang[key]
	end

	-- Fallback a inglés
	if M.strings.en[key] then
		return M.strings.en[key]
	end

	-- Si no existe, devolver la clave
	return key
end

--- Alias corto para M.get
function M.t(key)
	return M.get(key)
end

--- Cambia el idioma actual
function M.set_language(lang)
	if M.strings[lang] then
		M.current_language = lang
		print("[Localization] Idioma cambiado a: " .. lang)
		return true
	end
	return false
end

--- Lista de idiomas disponibles
function M.get_available_languages()
	local langs = {}
	for lang, _ in pairs(M.strings) do
		table.insert(langs, lang)
	end
	return langs
end

return M