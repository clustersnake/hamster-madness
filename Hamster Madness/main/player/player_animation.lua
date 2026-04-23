-- player_animation.lua
-- Animaciones procedurales + sprites direccionales

local M = {}

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

local CONFIG = {
	-- Idle
	idle_breath_speed = 2.5,
	idle_breath_amount = 0.03,

	-- Walk
	walk_tilt_amount = 6,
	walk_bounce_speed = 14,
	walk_bounce_amount = 0.05,

	-- Dirección
	squash_amount = 0.12,

	-- Daño
	damage_squash_x = 1.3,
	damage_squash_y = 0.7,
}

-- Nombres de las animaciones por defecto (fallback)
local DEFAULT_ANIMS = {
	idle_down = "idle_down",
	idle_up = "idle_up",
	idle_side = "idle_right",
	walk_down = "walk_down",
	walk_up = "walk_up",
	walk_side = "walk_right",
	fallen = "fallen_hamster",
}

-- ============================================================
-- INICIALIZACIÓN
-- ============================================================

function M.init_state(self)
	self.anim_timer = 0
	self.last_direction_x = 0
	self.is_animating_damage = false
	self.current_anim = nil
	self.current_facing_dir = "down"

	-- NUEVO: Animaciones del personaje (se configuran con set_character_anims)
	self.character_anims = nil
end

-- ============================================================
-- NUEVO: CONFIGURAR ANIMACIONES DEL PERSONAJE
-- ============================================================

--- Configura las animaciones basadas en los datos del personaje
-- @param character_data Datos del personaje desde character_data.lua
function M.set_character_anims(self, character_data)
	if not character_data or not character_data.animations then
		print("[Animation] Sin datos de personaje, usando animaciones por defecto")
		self.character_anims = nil
		return
	end

	local anims = character_data.animations

	-- Construir tabla de animaciones para este personaje
	self.character_anims = {
		idle_down = anims.idle_down,
		idle_up = anims.idle_up,
		idle_side = anims.idle_right,  -- "side" usa el sprite "right" con flip
		walk_down = anims.walk_down,
		walk_up = anims.walk_up,
		walk_side = anims.walk_right,  -- "side" usa el sprite "right" con flip
		fallen = anims.fallen,
	}

	print("[Animation] Animaciones configuradas para: " .. character_data.name)
	print("[Animation] Ejemplo idle_down: " .. self.character_anims.idle_down)
end

--- Obtiene el nombre de animación correcto (usa personaje o fallback)
local function get_anim_name(self, anim_key)
	if self.character_anims and self.character_anims[anim_key] then
		return self.character_anims[anim_key]
	end
	return DEFAULT_ANIMS[anim_key]
end

-- ============================================================
-- DETERMINAR DIRECCIÓN DEL SPRITE
-- ============================================================

local function get_facing_direction(facing)
	local abs_x = math.abs(facing.x)
	local abs_y = math.abs(facing.y)

	-- Determinar si es más horizontal o vertical
	if abs_y > abs_x then
		if facing.y > 0 then
			return "up", false
		else
			return "down", false
		end
	else
		-- Horizontal: usar sprite "side" con flip
		local flip = facing.x < 0
		return "side", flip
	end
end

-- ============================================================
-- CAMBIAR ANIMACIÓN
-- ============================================================

local function set_animation(self, anim_key, flip_x)
	local anim_name = get_anim_name(self, anim_key)

	if self.current_anim ~= anim_name then
		self.current_anim = anim_name
		sprite.play_flipbook("#sprite", hash(anim_name))
	end

	-- Flip horizontal para mirar a la izquierda
	sprite.set_hflip("#sprite", flip_x or false)
end

-- ============================================================
-- UPDATE PRINCIPAL
-- ============================================================

function M.update(self, is_init)
	if self.is_animating_damage then
		return
	end

	if is_init then
		go.set_scale(vmath.vector3(1, 1, 1))
		go.set_rotation(vmath.quat())
		set_animation(self, "idle_down", false)
		return
	end

	local dt = 0.016
	self.anim_timer = self.anim_timer + dt

	local is_moving = vmath.length(self.direction) > 0.1

	-- Determinar dirección basada en facing (hacia el crosshair)
	local dir, flip = get_facing_direction(self.facing)
	self.current_facing_dir = dir

	if is_moving then
		M.update_walk(self, dt, dir, flip)
	else
		M.update_idle(self, dir, flip)
	end
end

-- ============================================================
-- IDLE: Respiración + sprite direccional
-- ============================================================

function M.update_idle(self, dir, flip)
	-- Seleccionar animación idle según dirección
	local anim_key = "idle_" .. dir
	set_animation(self, anim_key, flip)

	-- Efecto de respiración
	local breath = math.sin(self.anim_timer * CONFIG.idle_breath_speed) * CONFIG.idle_breath_amount
	local scale_x = 1 - breath
	local scale_y = 1 + breath

	go.set_scale(vmath.vector3(scale_x, scale_y, 1))
	go.set_rotation(vmath.quat())

	self.last_direction_x = 0
end

-- ============================================================
-- WALK: Bounce + inclinación + sprite direccional
-- ============================================================

function M.update_walk(self, dt, dir, flip)
	-- Seleccionar animación walk según dirección
	local anim_key = "walk_" .. dir
	set_animation(self, anim_key, flip)

	-- Detectar cambio de dirección horizontal (para squash)
	if self.direction.x ~= 0 then
		local new_dir = self.direction.x > 0 and 1 or -1
		if self.last_direction_x ~= 0 and new_dir ~= self.last_direction_x then
			M.on_direction_change(self)
		end
		self.last_direction_x = new_dir
	end

	-- Inclinación sutil en dirección del movimiento
	local tilt = 0
	if self.direction.x ~= 0 then
		tilt = self.direction.x > 0 and -CONFIG.walk_tilt_amount or CONFIG.walk_tilt_amount
	end
	go.set_rotation(vmath.quat_rotation_z(math.rad(tilt)))

	-- Bounce al caminar
	local bounce = math.abs(math.sin(self.anim_timer * CONFIG.walk_bounce_speed)) * CONFIG.walk_bounce_amount
	local scale_x = 1 + bounce
	local scale_y = 1 - bounce

	go.set_scale(vmath.vector3(scale_x, scale_y, 1))
end

-- ============================================================
-- CAMBIO DE DIRECCIÓN
-- ============================================================

function M.on_direction_change(self)
	go.cancel_animations(".", "scale")
	go.set_scale(vmath.vector3(1 + CONFIG.squash_amount, 1 - CONFIG.squash_amount, 1))
	go.animate(".", "scale", go.PLAYBACK_ONCE_FORWARD, 
	vmath.vector3(1, 1, 1), 
	go.EASING_OUTBOUNCE, 
	0.25
)
end

-- ============================================================
-- DAÑO
-- ============================================================

function M.on_damage(self)
self.is_animating_damage = true

go.cancel_animations(".", "scale")

-- Flash blanco
sprite.set_constant("#sprite", "tint", vmath.vector4(10, 10, 10, 1))

timer.delay(0.05, false, function()
	if not go.exists(go.get_id()) then return end
	sprite.set_constant("#sprite", "tint", vmath.vector4(1, 0.3, 0.3, 1))
end)

timer.delay(0.15, false, function()
	if not go.exists(go.get_id()) then return end
	sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
end)

go.set_scale(vmath.vector3(CONFIG.damage_squash_x, CONFIG.damage_squash_y, 1))
go.animate(".", "scale", go.PLAYBACK_ONCE_FORWARD,
vmath.vector3(1, 1, 1),
go.EASING_OUTBOUNCE,
0.3,
0,
function()
	self.is_animating_damage = false
end
)
end

-- ============================================================
-- NUEVO: ANIMACIÓN DE CAÍDO
-- ============================================================

function M.play_fallen(self)
local anim_name = get_anim_name(self, "fallen")
sprite.play_flipbook("#sprite", hash(anim_name))

-- Resetear transformaciones
go.set_scale(vmath.vector3(1, 1, 1))
go.set_rotation(vmath.quat())
end

-- ============================================================
-- RESET
-- ============================================================

function M.reset(self)
go.cancel_animations(".", "scale")
go.set_scale(vmath.vector3(1, 1, 1))
go.set_rotation(vmath.quat())
sprite.set_constant("#sprite", "tint", vmath.vector4(1, 1, 1, 1))
sprite.set_hflip("#sprite", false)
self.anim_timer = 0
self.is_animating_damage = false
end

return M