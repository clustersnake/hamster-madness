-- player_animation.lua
-- Sistema de animación del jugador

local M = {}

function M.update(self, force)
	local dominated_direction
	local is_moving = vmath.length(self.direction) > 0

	if math.abs(self.facing.x) > math.abs(self.facing.y) then
		dominated_direction = "right"
		self.flip_x = self.facing.x < 0
	else
		dominated_direction = self.facing.y > 0 and "up" or "down"
		self.flip_x = false
	end

	local prefix = is_moving and "walk_" or "idle_"
	local anim_hash = hash(prefix .. dominated_direction)

	if self.current_anim ~= anim_hash or force then
		self.current_anim = anim_hash
		sprite.play_flipbook("#sprite", anim_hash)
	end

	sprite.set_hflip("#sprite", self.flip_x)
end

function M.init_state(self)
	self.current_anim = nil
	self.flip_x = false
end

return M